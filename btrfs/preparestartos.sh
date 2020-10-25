#!/usr/bin/env bash
set -x

disk="$1"
bootfiles=multios/btrfs/distros/boot/files/fat32
linuxfiles=multios/btrfs/distros/boot/files/linux

apt install -y qemu qemu-user-static binfmt-support systemd-container git
git clone https://github.com/raspberrypisig/usb-msd-raspberrypi-multios multios

mkdir -p usb3

mount|grep $disk|awk '{print $1}'|xargs umount

mount -t btrfs -o subvol=boot ${disk}p3 usb3
mount ${disk}p1 usb3/boot

cp -rv $bootfiles/* usb3/boot
rsync -av $linuxfiles/ usb3

#chmod +x setup.sh
#cp setup.sh usb3
#systemd-nspawn -D usb3 /setup.sh 
#rm usb3/setup.sh

umount usb3/boot
umount usb3
rm -rf usb3
