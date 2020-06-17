#!/usr/bin/env bash
set -x

setup() {
  usbdevice="$1"
  raspbianliteimg="$2"

  loopdevice=$(losetup --show -Pf "$raspbianliteimg")
  mkdir -p raspbianboot
  mkdir -p raspbian
  mkdir -p {usb1,usb2,usb3}
  mount -o ro ${loopdevice}p1 raspbianboot
  mount -o ro ${loopdevice}p2 raspbian
  mount ${usbdevice}1 usb1
  mount ${usbdevice}2 usb2
  mount ${usbdevice}3 usb3

  cp -r raspbianboot/* usb1/
  rsync -a raspbian/ usb3/
  wget -O usb3/etc/fstab https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/fstab
  wget https://github.com/raspberrypi/rpi-eeprom/releases/download/v2020.05.28-137ad/usb-msd-boot-firmware.zip
  unzip -d usb1 usb-msd-boot-firmware.zip
  wget -O usb1/config.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/partition1/config.txt
  wget -O usb1/cmdline.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/cmdline.txt
  cp -r usb1/* usb2/
  wget -O usb2/config.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/partition2/config.txt

  umount {usb1,usb2,usb3,raspbianboot,raspbian}
  losetup -D $loopdevice
}


addos() {
  osimg="$1"
  bootpart="$2"
  linuxpart="$3"
  name="$4"

  loopdevice=$(losetup --show -Pf "$osimg")
  mkdir -p osboot
  mkdir -p os
  mkdir -p usbboot
  mkdir -p usblinux
  mount -o ro ${loopdevice}p1 osboot
  mount -o ro ${loopdevice}p2 os
  mount $bootpart usbboot
  mount $linuxpart usblinux

  cp -r osboot/* $usbboot
  rsync -a usblinux/ $usblinux
  wget -O $usblinux/etc/fstab https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/blob/master/fstab
  sed -i -r "s/\/dev\/sda1/$bootpart/" $usblinux/etc/fstab
  sed -i -r "s/\/dev\/sda2/$linuxpart/" $usblinux/etc/fstab

  umount {usbboot,usblinux,osboot,os}
  losetup -D $loopdevice
}


case "$1" in
  "setup")
    shift
    setup "$@"
   ;;
  "addon")
    shift
    addon "$@"
   ;;
  *)
    echo help
    ;;


esac
