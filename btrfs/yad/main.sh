#!/usr/bin/env bash
set -x
disk="$1"



pipefile=/tmp/multipi4.fifo
selectedos=/tmp/multipi4.selection
fd=4

rm -f $pipefile
rm -f $selectedos


mkfifo $pipefile
touch $selectedos

mkdir -p /tmp/multipi4/distros
mount ${disk}2 /tmp/multipi4/distros

if [ ! -f /tmp/multipi4/distros/oslist.txt ];
then
oslist=
else
oslist=$(cat /tmp/multipi4/distros/oslist.txt)
fi


exec 4<> $pipefile


echo $oslist
umount ${disk}2
echo -e "\f" > $pipefile &
sleep 1
echo -e "$oslist" > $pipefile &


output="$(yad --center --borders=10 --title='MultiPi4' --width=600 --height=400 --no-headers --buttons-layout=center --kill-parent  \
        --text="\nInstalled OS List\n" --text-align=center  \
        --list --separator='\n'  \
        --column=:Name --print-column=1 \
        --select-action="/bin/sh -c \"printf \%\s'\n' %s > $selectedos \"" \
        --button="Add OS:bash addos.sh $disk" \
        --button="Move Up:bash moveup.sh $disk" \
        --button="Move Down:bash movedown.sh $disk" \
        --button="Edit:bash edit.sh $disk" \
        <&4 ) "

