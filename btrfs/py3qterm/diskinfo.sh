#!/usr/bin/env bash

#set -x

usbdevices=$(readlink -f /dev/disk/by-id/{usb*,ata*}|sed -r  '/[0-9]+/d'|sort)

for usbdisk in $usbdevices
do
  diskinfo=$(udevadm info $usbdisk)
  capacity=$(fdisk -l $usbdisk|head -n1|awk '{print $3 " " $4}'|cut -f1 -d',')
  
  echo $usbdisk
  #echo $diskinfo
  echo $capacity
  
done
