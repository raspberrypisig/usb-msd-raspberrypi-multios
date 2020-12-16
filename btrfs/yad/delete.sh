#!/usr/bin/env bash

disk="$1"
selectedos="$2"

createsubvolumename() {
  name="$1"
  typeset -l newvolname
  newvolname=${name// /_}
  newvolname=${newvolname//./__}
  echo @$newvolname  
}

echo $selectedos
echo $disk
mkdir -p /tmp/multipi4/deleting3
mkdir -p /tmp/multipi4/deleting2
mount ${disk}2 /tmp/multipi4/deleting2
mount ${disk}3 /tmp/multipi4/deleting3
vol=$(createsubvolumename "$selectedos") 
rm -rf /tmp/multipi4/deleting3/$vol
oslist=$(sed "/$selectedos/d" /tmp/multipi4/deleting2/oslist.txt)
sed -i "/$selectedos/d" /tmp/multipi4/deleting2/oslist.txt
(
echo -e "\f" > /tmp/multipi4.fifo
echo -e "$oslist" > /tmp/multipi4.fifo
)
echo "Sleeping for 20 seconds"
sleep 20
umount ${disk}2
umount ${disk}3

