#!/usr/bin/env bash
set -x
disk="$1"

selectedos=$(cat /tmp/multipi4.selection)


output="$(yad --center --borders=10 \
         --text "OS: $selectedos" \
         --button "Cancel:0" \
         --button "Delete:1" \
)"

buttonpressed=$?

createsubvolumename() {
  name="$1"
  typeset -l newvolname
  newvolname=${name// /_}
  newvolname=${newvolname//./__}
  echo @$newvolname  
}

if [ $buttonpressed -eq 1 ];
then
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
  sleep 2
  umount ${disk}2
  umount ${disk}3
fi
sleep 120