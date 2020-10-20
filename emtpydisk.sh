#!/usr/bin/env bash
set -x

raspbian_image="$1"
usb_disk="$2"

sfdisk $usb_disk <<EOF
label: gpt
,200MiB,EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
,10GiB,EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
,,0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

mkfs.vfat "${usb_disk}p1"
mkfs.vfat "${usb_disk}p2"
mkfs.btrfs -f "${usb_disk}p3"

loop=$(losetup --show -Pf $raspbian_image)

mkdir -p {p1,p2,usb1,usb3}
mount ${loop}p1 p1
mount ${loop}p2 p2
mount ${usb_disk}p1 usb1
mount ${usb_disk}p3 usb3
cd usb3
btrfs subvolume create 1
cd ..
cp -rv p1/* usb1
rsync -avu p2/ usb3/1

losetup -D $loop
umount {p1,p2,usb1,usb3}}
rm -rf {p1,p2,usb1,usb3}
