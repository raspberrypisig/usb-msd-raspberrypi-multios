#!/usr/bin/env bash
set -x

volname="$1"

#apt update
#apt install -y initramfs-tools btrfs-tools btrfs-progs


#echo btrfs >> /etc/initramfs-tools/modules

VERSION=$(find /lib/modules -name *.el8 -exec basename {} \; )
dnf update
dnf install -y btrfs-progs
echo btrfs >> /etc/dracut.conf
dracut /boot/initrd.img $VERSION


sed -i "s/PLACEHOLDER/$volname/" /boot/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab

systemctl disable sssd

# Disable kernel updates
#sudo apt-mark hold libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc libraspberrypi0
#sudo apt-mark hold raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers

#systemctl disable resize2fs_once
#systemctl disable dphys-swapfile
