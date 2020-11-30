#!/usr/bin/env bash
set -x

disk="$1"


#output="$(yad --center --borders=30 --title='Multipi4 - Add OS' --width=600 --height=400 --no-headers --buttons-layout=center  \
#        --text="\nAdd OS\n" --text-align=center  \
#        --form \
#        --field="Name" \
#        --field="Base distro":CB \
#"" "" "" "Raspberry Pi OS" \
#
#)"

output="$(yad --width=600 --center --height=400 --buttons-layout=center --title="Multipi4 - Add OS" --text="Add OS" \
--image="/usr/share/icons/Tango/scalable/emotes/face-smile.svg" \
--form  \
--field=Name "" \
--field="Base distro":CB \
"Raspberry Pi OS\!Ubuntu" \
--field="Image(*.img)":SFL  \
)"


buttonpressed=$?
if [ $buttonpressed -eq 0  ];
then
#echo $output
disk=$(echo $output | cut -f1 -d':')
bash existingmultipi4.sh $disk
existing=$?

if [ $existing -eq 0 ];
then
  bash main.sh $disk
else
  bash 2.sh $disk
fi



else
exit 1
fi
