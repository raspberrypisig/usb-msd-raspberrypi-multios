#!/usr/bin/env bash
set -x

volname="$1"

apt update
apt install -y initramfs-tools btrfs-tools btrfs-progs
VERSION=$(find /lib/modules -name *v7l+ -exec basename {} \; )
mkinitramfs -o /initramfs-btrfs -v $VERSION

sed -i "s/PLACEHOLDER/$volname/" /boot/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab

# Disable kernel updates
sudo apt-mark hold libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc libraspberrypi0
sudo apt-mark hold raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers

systemctl disable resize2fs_once
systemctl disable dphys-swapfile
