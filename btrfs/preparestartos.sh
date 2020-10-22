#!/usr/bin/env bash

disk="$1"
bootfiles=usb-msd-raspberrypi-multios/btrfs/distros/boot/files/fat32
linuxfiles=usb-msd-raspberrypi-multios/btrfs/distros/boot/files/btrfs

apt install -y qemu qemu-user-static binfmt-support systemd-container
git clone https://github.com/raspberrypisig/usb-msd-raspberrypi-multios

mkdir -p usb3

mount ${disk}p3 usb3
mount ${disk}p1 usb3/boot

cp -rv $bootfiles/* usb3/boot
rsync -av $linuxfiles/ usb3

chmod +x setup.sh
cp setup.sh usb3
systemd-nspawn -D usb3 /setup.sh 
rm usb3/setup.sh

umount {usb3/boot, usb3}
rm -rf usb3

