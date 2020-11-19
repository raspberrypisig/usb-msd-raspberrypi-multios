#!/usr/bin/env bash

#set -x

usbdevices=$(readlink -f /dev/disk/by-id/{usb*,ata*}|sed -r  '/[0-9]+/d'|sort)

for usbdisk in $usbdevices
do
  model=$(udevadm info $usbdisk|grep ID_MODEL=|cut -f2- -d'=')
  vendor=$(udevadm info $usbdisk|grep ID_VENDOR=|cut -f2- -d'=')
  
  capacity=$(fdisk -l $usbdisk|head -n1|awk '{print $3 " " $4}'|cut -f1 -d',')
  
  echo "$vendor $model $capacity"
done
