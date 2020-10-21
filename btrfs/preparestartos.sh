#!/usr/bin/env bash

disk="$2"
bootfiles=distros/boot/files/fat32
linuxfiles=distros/boot/files/btrfs

mkdir -p {usb1,usb3}

mount ${disk}p1 usb1
mount ${disk}p3 usb3

cp -rv $bootfiles/* usb1
rsync -av $linuxfiles/ usb3

apt install -y qemu qemu-user-static binfmt-support systemd-container
chmod +x setup.sh
cp setup.sh usb3
systemd-nspawn -D usb3 /setup.sh 
rm usb3/setup.sh

umount {usb1,usb3}
rm -rf {usb1,usb3}

