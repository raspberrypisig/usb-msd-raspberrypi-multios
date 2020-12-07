#!/usr/bin/env bash

set -x
usb=$(ls /dev/disk/by-id/usb* 2>/dev/null)
ata=$(ls /dev/disk/by-id/ata* 2>/dev/null)

usbdevices=$(readlink -m -f $usb $ata|sed -r  '/[0-9]+/d'|sort)

for usbdisk in $usbdevices
do
  model=$(udevadm info $usbdisk|grep ID_MODEL=|cut -f2- -d'=')
  vendor=$(udevadm info $usbdisk|grep ID_VENDOR=|cut -f2- -d'=')
  capacity=$(fdisk -l $usbdisk|head -n1|awk '{print $3 " " $4}'|cut -f1 -d',')
  if [ ! $vendor ];
  then
  echo "${usbdisk}: $model $capacity"  
  else
  echo "${usbdisk}: $vendor $model $capacity"
  fi
done
