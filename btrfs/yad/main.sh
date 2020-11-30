#!/usr/bin/env bash
set -x
disk="$1"


mkdir -p /tmp/multipi4/distros
mount ${disk}2 /tmp/multipi4/distros

if [ ! -f /tmp/multipi4/distros/oslist.txt ];
then
oslist=
else
oslist=$(cat /tmp/multipi4/distros/oslist.txt)
fi

echo $oslist
umount ${disk}2

output="$(echo -e "$oslist" | yad --center --borders=10 --title='MultiPi4' --width=600 --height=400 --no-headers --buttons-layout=center  \
        --text="\nInstalled OS List\n" --text-align=center  \
        --list --separator='\n'  \
        --column=:Name --print-column=1 \
        --button="Add OS:0" \
        --button="Move Up:1" \
        --button="Move Down:2" \
        )"

button=$?

case $button in 
0)
bash addos.sh $disk
;;

1)
bash moveup.sh $output
;;
2)
bash movedown.sh $output
;;
252)
exit 1
;;
esac
