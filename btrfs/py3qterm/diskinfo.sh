#!/usr/bin/env bash

usbdevices=$(readlink -f /dev/disk/by-id/usb*|sed -r  '/[0-9]+/d'|sort)

for usbdisk in $usbdevices
do
  diskinfo=$(udevadm info $usbdisk)
  capacity=$(fdisk -l /dev/sdd|head -n1|awk '{print $3 " " $4}'|cut -f1 -d',')
  
  echo $diskinfo
  echo $capacity
  
done
