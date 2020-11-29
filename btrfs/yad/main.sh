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

output="$(echo -e "$oslist" | yad --center --borders=30 --title='Pi-Apps' --width=600 --height=400 --no-headers --buttons-layout=center  \
        --text="\nPlease select drive to make into a multiboot Pi disk\n" --text-align=center  \
        --list --separator='\n'  \
        --column=:Name --print-column=1 \
        --button=Select:0 \
        --button=Cancel:1 \
        )"


