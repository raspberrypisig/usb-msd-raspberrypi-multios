#!/usr/bin/env bash
set -e
declare -A oslist
str=
for i in {2..10}
do
fat=/tmp/fat
mkdir -p $fat
mount "/dev/sda$i" $fat
if [ -f  "$fat/NAME" ];
then
  os=$(cat "$fat/NAME")
  oslist["$os"]=$i
  str="$str $os $os" 
fi
umount $fat
done
#echo "${!oslist[@]}"
echo $str
#exit 0
#sleep 10
clear
#a="one two three  four fix mix"
CHOICE=$(whiptail --title "Choose OS" --menu " "  --nocancel --noitem   20 70 5 \
$str 3>&1 1>&2 2>&3 )
#echo $CHOICE
echo ${oslist[$CHOICE]}
sudo reboot ${oslist[$CHOICE]}
