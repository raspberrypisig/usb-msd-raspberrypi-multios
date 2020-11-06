#!/usr/bin/env bash
set -x

volname="$1"

apt update
apt install -y initramfs-tools btrfs-tools btrfs-progs

echo btrfs >> /etc/initramfs-tools/modules

VERSION=$(find /lib/modules -name '*-raspi' -exec basename {} \; )
mkinitramfs -o /boot/initramfs-btrfs -v $VERSION

sed -i "s/PLACEHOLDER/$volname/" /boot/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab
