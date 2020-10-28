#!/usr/bin/env bash
set -x

if [ $# -ne 1 ];
then
 echo $0 [disk]
 exit 1
fi

disk="$1"
bootfiles=multios/btrfs/distros/boot/boot
linuxfiles=multios/btrfs/distros/boot/linux
setupscript=multios/btrfs/distros/boot/setup.sh

apt install -y qemu qemu-user-static binfmt-support systemd-container git subversion
git clone https://github.com/raspberrypisig/usb-msd-raspberrypi-multios multios


mkdir -p {usb1,usb2,usb3}

mount|grep $disk|awk '{print $1}'|xargs umount

mount ${disk}1 usb1
mount ${disk}2 usb2
mount -t btrfs -o subvol=@boot ${disk}3 usb3

cp -r $bootfiles/* usb1
rsync -a $linuxfiles/ usb3

chmod +x $setupscript
cp $setupscript usb3
systemd-nspawn -D usb3 /setup.sh
cp usb3/initramfs-btrfs usb1
rm usb3/initramfs-btrfs
rm usb3/setup.sh

svn co https://github.com/raspberrypi/firmware/trunk/boot
cp boot/* usb2
rm -rf boot

umount {usb1,usb2,usb3}
rm -rf {usb1,usb3,multios}
