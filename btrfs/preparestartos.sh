#!/usr/bin/env bash
set -x

disk="$1"
bootfiles=multios/btrfs/distros/boot/files/boot
linuxfiles=multios/btrfs/distros/boot/files/linux
setupscript=multios/btrfs/distros/boot/setup.sh

apt install -y qemu qemu-user-static binfmt-support systemd-container git
git clone https://github.com/raspberrypisig/usb-msd-raspberrypi-multios multios


mkdir -p {usb1,usb3}

mount|grep $disk|awk '{print $1}'|xargs umount

mount ${disk}1 usb1
mount -t btrfs -o subvol=@boot ${disk}3 usb3

cp -rv $bootfiles/* usb1
rsync -av $linuxfiles/ usb3

chmod +x $setupscript
cp $setupscript usb3
systemd-nspawn -D usb3 /setup.sh
cp usb3/initramfs-btrfs usb1
rm usb3/initramfs-btrfs
rm usb3/setup.sh


umount {usb1,usb3}
rm -rf {usb1,usb3,multios}
