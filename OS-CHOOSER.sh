#!/bin/bash
#set -x
#set -e
#mount -t proc proc /proc
#sleep 10
#mount -t sysfs sys /sys
#mount -t tmpfs tmp /tmp

#mount /boot
#mount / -o remount,ro

SACRIFICIAL_BOOTPARTITION=3
TEMP_DIR=/tmp
SACRIFICIAL_MOUNT_DIR="${TEMP_DIR}/boot"

declare -A oslist
options=()

fat_partitions=$(parted -l /dev/sda|grep fat|sed -n '3,$p'|awk '{print $1}')

for i in $fat_partitions
do
mkdir -p TEMP_DIR
mount "/dev/sda$i" $TEMP_DIR
if [ -f  "${TEMP_DIR}/NAME" ];
then
  os=$(cat "${TEMP_DIR}/NAME")
  oslist["$os"]=$i
  options+=("$os" "$os") 
fi
umount $TEMP_DIR
done

#echo "${!oslist[@]}"
#echo $str

#sleep 60
#exit 0
#sleep 10
#clear
#a="one two three  four fix mix"
CHOICE=$(whiptail --title "Choose OS" --menu " "  --nocancel --noitem   20 70 5 "${options[@]}" 3>&1 1>&2 2>&3)
#set -x
bootpart="${oslist[$CHOICE]}"
echo $bootpart
#sleep 3
if [ $bootpart -gt 4 ];
then
  bootpart=$(( bootpart + 1  ))
  mkdir -p "${TEMP_DIR}"
  mount "/dev/sda${SACRIFICIAL_BOOTPARTITION}" "${TEMP_DIR}"
  sed -i -r "s/root=([^ ]*) /root=\/dev\/sda${bootpart} /" /tmp/mnt/cmdline.txt
  #cat /tmp/mnt/cmdline.txt
  #sleep 10
  umount "${TEMP_DIR}/cmdline.txt"
  bootpart=4
fi
sudo reboot $bootpart
#echo $CHOICE
#echo ${oslist[$CHOICE]}
#sudo reboot ${oslist[$CHOICE]}
