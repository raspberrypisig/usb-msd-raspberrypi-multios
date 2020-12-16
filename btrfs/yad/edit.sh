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

if [ $buttonpressed -eq 1 ];
then
gnome-terminal --wait -- bash ./delete.sh "$disk" "$selectedos"
fi
echo "sleep for 20 seconds"
sleep 20