#!/usr/bin/env bash
set -x
disk="$1"

mount ${disk}2 /tmp/multipi4/distros

selectedos=$(cat /tmp/multipi4.selection)
oslistfile=/tmp/multipi4/distros/oslist.txt

linenumber=$(grep -n "$selectedos" $oslistfile | cut -f1 -d':')
linecount=$(cat $oslistfile| wc -l)


if [ $linenumber -eq $linecount ];
then
umount ${disk}2
exit 0
fi


echo -e "\f" > /tmp/multipi4.fifo 

newlist=$(sed -n "/$selectedos/{h;n;p;g};p" /tmp/multipi4/distros/oslist.txt)
echo $newlist
num=$(echo $newlist|wc -l)
echo $num
echo -e "$newlist" > /tmp/multipi4.fifo 
echo  "$newlist" > $oslistfile
umount ${disk}2
