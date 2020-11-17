#!/usr/bin/env bash
set -x

volname="$1"

cp /etc/resolv.conf /etc/resolv.conf.old
echo nameserver 8.8.8.8 > /etc/resolv.conf

apt update
apt install -y initramfs-tools btrfs-tools btrfs-progs

echo btrfs >> /etc/initramfs-tools/modules

VERSION=$(find /lib/modules -name '*-raspi' -exec basename {} \; )
update-initramfs -c -k $VERSION

sed -i "s/PLACEHOLDER/$volname/" /boot/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab

cp /etc/resolv.conf.old /etc/resolv.conf
