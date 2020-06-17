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
  cp -r raspbianboot/* usb1/ 
  rsync -au raspbian/ usb3/
  wget https://github.com/raspberrypi/rpi-eeprom/releases/download/v2020.05.28-137ad/usb-msd-boot-firmware.zip
  unzip -d usb1 usb-msd-boot-firmware.zip
  cp -r usb1/* usb2/
}

addos() {

}



