#!/usr/bin/env bash

sudo apt install -y initramfs-tools btrfs-tools btrfs-progs
echo btrfs >> /etc/initramfs-tools/modules	
VERSION=$(<pre>find /lib/modules   -name &apos;*v7l+&apos; -exec basename {} \;</pre>)
mkinitramfs -o /boot/initramfs-btrfs.gz -v $VERSION
# Disable kernel updates
sudo apt-mark hold libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc libraspberrypi0
sudo apt-mark hold raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers
