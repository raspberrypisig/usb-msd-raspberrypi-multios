#!/usr/bin/env bash

set -x

mkdir -p /tmp/usb2
mount /dev/sda2 /tmp/usb2
if [ -f /tmp/usb2/oslist.txt ];
then
  options=()
  while read line
  do
    options+=("$line" "$line")
  done < /tmp/usb2/oslist.txt
  echo "${options[@]}"
fi
umount /tmp/usb2
rm -rf /tmp/usb2
