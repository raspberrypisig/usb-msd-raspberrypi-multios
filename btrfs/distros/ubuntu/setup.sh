#!/usr/bin/env bash
set -x

volname="$1"

mv /etc/resolv.conf /etc/resolv.conf.old
echo nameserver 8.8.8.8 > /etc/resolv.conf

apt update
apt install -y initramfs-tools btrfs-progs

echo btrfs >> /etc/initramfs-tools/modules

VERSION=$(find /lib/modules -name '*-raspi' -exec basename {} \; )
update-initramfs -c -k $VERSION
cp /boot/initrd.img-$VERSION /boot/firmware/initrd.img

sed -i "s/PLACEHOLDER/$volname/" /boot/firmware/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab

mv /etc/resolv.conf.old /etc/resolv.conf

apt-mark hold linux-headers-$VERSION linux-modules-$VERSION linux-image-$VERSION
