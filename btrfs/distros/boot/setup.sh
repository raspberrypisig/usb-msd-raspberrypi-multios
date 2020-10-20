#!/usr/bin/env bash

sudo apt install -y initramfs-tools btrfs-tools
echo btrfs >> /etc/initramfs-tools/modules	
mkinitramfs -o /boot/initramfs-btrfs.gz
# Disable kernel updates
sudo apt-mark hold libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc libraspberrypi0
sudo apt-mark hold raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers
