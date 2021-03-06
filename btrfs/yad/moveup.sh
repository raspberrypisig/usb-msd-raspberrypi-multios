#!/usr/bin/env bash
set -x
disk="$1"

mount ${disk}2 /tmp/multipi4/distros

selectedos=$(cat /tmp/multipi4.selection)
oslistfile=/tmp/multipi4/distros/oslist.txt
#cat $oslistfile

linenumber=$(grep -n "$selectedos" $oslistfile | cut -f1 -d':')

if [ $linenumber -eq 1 ];
then
umount ${disk}2
exit 0
fi

echo -e "\f" > /tmp/multipi4.fifo 

newlist=$(awk "!/$selectedos/ { if (NR > 1) print prev; prev=\$0} /$selectedos/ {print \$0;} END {print prev}" < /tmp/multipi4/distros/oslist.txt)
echo $newlist
num=$(echo $newlist|wc -l)
echo $num
echo -e "$newlist" > /tmp/multipi4.fifo 
echo  "$newlist" > $oslistfile
umount ${disk}2
