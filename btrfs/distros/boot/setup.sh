#!/usr/bin/env bash

apt update
apt install -y initramfs-tools btrfs-tools btrfs-progs
echo btrfs >> /etc/initramfs-tools/modules	
VERSION=$(find /lib/modules -name *v7l+ -exec basename {} \; )
mkinitramfs -o /initramfs-btrfs -v $VERSION
# Disable kernel updates
apt-mark hold libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc libraspberrypi0
apt-mark hold raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers

services_disable=("resize2fs_once" "networking" "dhcpcd" "rpi-eeprom-update" "avahi-daemon" "dphys-swapfile" "wpa_supplicant" "rc-local" )

for service in "${services_disable[@]}"
do
  systemctl disable $service
done


