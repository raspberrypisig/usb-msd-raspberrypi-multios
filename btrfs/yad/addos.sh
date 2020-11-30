#!/usr/bin/env bash
set -x

disk="$1"

output="$(yad --width=600 --center --height=400 --buttons-layout=center --title="Multipi4 - Add OS" --text="Add OS" \
--image="/usr/share/icons/Tango/scalable/emotes/face-smile.svg" \
--form  \
--field=Name "" \
--field="Base distro":CB \
"Raspberry Pi OS\!Ubuntu" \
--field="Image(*.img)":SFL  \
--button="OK:0" \
--button="Cancel:1" \
)"


buttonpressed=$?
if [ $buttonpressed -eq 0  ];
then
echo $output
else
exit 1
fi
