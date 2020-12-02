#!/usr/bin/env bash
set -x
disk="$1"

pipefile=/tmp/multipi4.fifo
selectedos=/tmp/multipi4.selection

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
echo -e  "$oslist" > $pipefile &
exec 4<> $pipefile
fi



echo $oslist
umount ${disk}2

output="$(yad --center --borders=10 --title='MultiPi4' --width=600 --height=400 --no-headers --buttons-layout=center --kill-parent  \
        --text="\nInstalled OS List\n" --text-align=center  \
        --list --separator='\n'  \
        --column=:Name --print-column=1 \
        --select-action="/bin/sh -c \"printf \%\s'\n' %s > $selectedos \"" \
        --button="Add OS:0" \
        --button="Move Up:bash moveup.sh $disk" \
        --button="Move Down:2" \
        <&4 )"
echo $output
button=$?
exit 0
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
exit 0
;;
esac
