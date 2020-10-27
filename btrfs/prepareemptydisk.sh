#!/usr/bin/env bash
set -x

if [ $# -ne 2 ];
then
 echo $0 [raspbian_image] [usb_disk]
 exit 1
fi

raspbian_image="$1"
usb_disk="$2"

mount|grep $usb_disk|awk '{print $1}'|xargs umount

sfdisk -f $usb_disk <<EOF
label: dos
,200MiB,c
,400MiB,c
,,83
EOF

partprobe "${usb_disk}"
sleep 1
mkfs.vfat "${usb_disk}1"
mkfs.vfat "${usb_disk}2"
mkfs.btrfs -f "${usb_disk}3"

loop=$(losetup --show -Pf $raspbian_image)

mkdir -p {p1,p2,usb1,usb3}
mount -o ro ${loop}p1 p1
mount -o ro ${loop}p2 p2
mount ${usb_disk}1 usb1
mount ${usb_disk}3 usb3
cd usb3
btrfs subvolume create @boot
cd ..
cp -r p1/* usb1
rsync -a p2/ usb3/@boot

umount {p1,p2,usb1,usb3}
rm -rf {p1,p2,usb1,usb3}
losetup -D $loop
