#!/usr/bin/env bash

sudo apt install -y initramfs-tools btrfs-tools
echo btrfs >> /etc/initramfs-tools/modules	
mkinitramfs -o /boot/initramfs-btrfs.gz
