#!/usr/bin/env bash

usb_disk="$1"

sfdisk $usb_disk <<EOF
label: gpt
,200MiB,EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
,10GiB,EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
,,0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

mkfs.vfat "${usb_disk}/p1"
mkfs.vfat "${usb_disk}/p2"
mkfs.btrfs "${usb_disk}/p3"



