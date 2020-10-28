#!/usr/bin/env bash

set -x

TEMP_DIR=/tmp/usb2
USB_DISK=/dev/sda
BTRFS_DIR=/tmp/usb3

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

CHOICE=$(whiptail --title "Choose OS" --menu " "  --nocancel --noitem   20 70 5 "${options[@]}" 3>&1 1>&2 2>&3)
volname=$(createsubvolumename "$CHOICE")
echo $volname

if [ -d $TEMP_DIR/$volname ];
then
  rm -rf $TEMP_DIR/$volname
fi

mkdir $TEMP_DIR/$volname
mkdir -p $BTRFS_DIR
mount ${USB_DISK}3 $BTRFS_DIR
cp "$BTRFS_DIR/@${volname}/boot/config.txt" $TEMP_DIR 
echo "os_prefix=${volname}/" >> $TEMP_DIR/config.txt

if [ -d $TEMP_DIR/$volname ];
then
  rm -rf $TEMP_DIR/$volname
fi

mkdir -p $TEMP_DIR/$volname
cp -r $BTRFS_DIR/@${volname}/boot/* $TEMP_DIR/$volname

umount $BTRFS_DIR
umount $TEMP_DIR
rm -rf $BTRFS_DIR
rm -rf $TEMP_DIR
reboot 2
