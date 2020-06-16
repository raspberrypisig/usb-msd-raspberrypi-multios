#!/bin/bash
#set -x
#set -e
#mount -t proc proc /proc
#sleep 10
#mount -t sysfs sys /sys
#mount -t tmpfs tmp /tmp

#mount /boot
#mount / -o remount,ro

USB_BLOCK_DEVICE=/dev/sda
SACRIFICIAL_BOOTPARTITION_NUMBER=3
SACRIFICIAL_BOOTPARTITION="${USB_BLOCK_DEVICE}${SACRIFICIAL_BOOTPARTITION_NUMBER}"
TEMP_DIR=/tmp
SACRIFICIAL_MOUNT_DIR="${TEMP_DIR}/boot"
TARGET_MOUNT_DIR="${TEMP_DIR}/targetboot"
KERNEL_NAME="kernel7l.img"

declare -A oslist
options=()

fat_partitions=$(sfdisk -l "$USB_BLOCK_DEVICE" | grep -i microsoft | sed -n '3,$p' | awk '{print $1}' | sed -r 's/[^0-9]*([0-9]+)/\1/')
#fat_partitions=$(parted -l $USB_BLOCK_DEVICE|grep fat|sed -n '3,$p'|awk '{print $1}')

for i in $fat_partitions
do
mount "${USB_BLOCK_DEVICE}$i" $TEMP_DIR
if [ -f  "${TEMP_DIR}/NAME" ];
then
  os=$(cat "${TEMP_DIR}/NAME")
  oslist["$os"]=$i
  options+=("$os" "$os") 
fi
umount $TEMP_DIR
done

#echo "${!oslist[@]}"

CHOICE=$(whiptail --title "Choose OS" --menu " "  --nocancel --noitem   20 70 5 "${options[@]}" 3>&1 1>&2 2>&3)
#echo $CHOICE
#echo ${oslist[$CHOICE]}
bootpart="${oslist[$CHOICE]}"
echo $bootpart

linuxpart=$(( bootpart + 1  ))
mkdir -p "$SACRIFICIAL_MOUNT_DIR"
mkdir -p "$TARGET_MOUNT_DIR"
mount "$SACRIFICIAL_BOOTPARTITION" $SACRIFICIAL_MOUNT_DIR
mount "${USB_BLOCK_DEVICE}${bootpart}" $TARGET_MOUNT_DIR
ESCAPED_USB_BLOCK_DEVICE=$(sed 's/\//\\\//g' <<< $USB_BLOCK_DEVICE)
sed -i -r "s/root=([^ ]*) /root=${ESCAPED_USB_BLOCK_DEVICE}${linuxpart} /" "${SACRIFICIAL_MOUNT_DIR}/cmdline.txt"
cp "${TARGET_MOUNT_DIR}/${KERNEL_NAME}" "${SACRIFICIAL_MOUNT_DIR}/${bootpart}.img"
sed -i -r "s/kernel=(.*)$/kernel=${bootpart}.img/" "${SACRIFICIAL_MOUNT_DIR}/config.txt"
umount "$SACRIFICIAL_MOUNT_DIR"
umount "$TARGET_MOUNT_DIR"
sudo reboot $SACRIFICIAL_BOOTPARTITION_NUMBER


