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

declare -A oslist
options=()
str=
for i in {2..10}
do
mkdir -p "${TEMP_DIR}"
mount "/dev/sda${SACRIFICIAL_BOOTPARTITION}" $fat
if [ -f  "$fat/NAME" ];
then
  os=$(cat "$fat/NAME")
  oslist["$os"]=$i
  str="$str $os $os"
  options+=("$os" "$os") 
fi
umount "${TEMP_DIR}"
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
  mkdir /tmp/mnt
  mount "/dev/sda3 /tmp/mnt
  sed -i -r "s/root=([^ ]*) /root=\/dev\/sda${bootpart} /" /tmp/mnt/cmdline.txt
  cat /tmp/mnt/cmdline.txt
  #sleep 10
  umount /tmp/mnt/cmdline.txt
  bootpart=4
fi
sudo reboot $bootpart
#echo $CHOICE
#echo ${oslist[$CHOICE]}
#sudo reboot ${oslist[$CHOICE]}
