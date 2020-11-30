#!/usr/bin/env bash
set -x
disk="$1"

output=$(yad --center --borders=15 --text "Raspbian Lite is needed for preparing multiboot Pi.\n Raspbian Lite image is usually named something like\n2020-08-20-raspios-buster-armhf-lite.img" \
       --text-align=center --form --field="Raspbian Image:SFL")
buttonpressed=$?

if [ $buttonpressed -eq 0 ];
then
raspbianimg=$(echo $output|sed  's/|//')
gnome-terminal --wait -- bash ./multipi4-preparedisk "$raspbianimg" "$disk"
status=$?
if [ $status -eq 0 ];
then
  echo "Finished."
else
  echo "Something went wrong."
fi

bash addos.sh $disk

else
exit 1
fi
