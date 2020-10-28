#!/usr/bin/env bash

set -x

TEMP_DIR=/tmp/usb2
USB_DISK=/dev/sda

createsubvolumename() {
  name="$1"
  typeset -l newvolname
  newvolname=${name// /_}
  echo $newvolname  
}

mkdir -p $TEMP_DIR
mount ${USB_DISK}2 $TEMP_DIR
if [ -f $TEMP_DIR/oslist.txt ];
then
  options=()
  while read line
  do
    options+=("$line" "$line")
  done < $TEMP_DIR/oslist.txt
fi
umount /tmp/usb2
rm -rf /tmp/usb2

CHOICE=$(whiptail --title "Choose OS" --menu " "  --nocancel --noitem   20 70 5 "${options[@]}" 3>&1 1>&2 2>&3)
osselection="${oslist[$CHOICE]}"
echo $osselection
volname=$(createsubvolumename $osselection)
echo $volname
