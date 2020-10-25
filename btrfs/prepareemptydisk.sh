#!/usr/bin/env bash
set -x

raspbian_image="$1"
usb_disk="$2"
secondpartitionsize=${3:-6}

mount|grep $usb_disk|awk '{print $1}'|xargs umount

sfdisk -f $usb_disk <<EOF
label: dos
,200MiB,EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
,${secondpartitionsize}GiB,0FC63DAF-8483-4772-8E79-3D69D8477DE4
,,0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

mkfs.vfat "${usb_disk}p1"
mkfs.ext4 -F "${usb_disk}p2"
#mkfs.vfat "${usb_disk}p2"
mkfs.btrfs -f "${usb_disk}p3"

loop=$(losetup --show -Pf $raspbian_image)

mkdir -p {p1,p2,usb1,usb2,usb3}
mount -o ro ${loop}p1 p1
mount -o ro ${loop}p2 p2
mount ${usb_disk}p1 usb1
mount ${usb_disk}p2 usb2
mount ${usb_disk}p3 usb3
btrfs subvolume create usb3/boot
cp -r p1/* usb1
rsync -a p2/ usb3/boot
rsync -a p2/ usb2


umount {p1,p2,usb1,usb2,usb3}
rm -rf {p1,p2,usb1,usb2,usb3}
losetup -D $loop
