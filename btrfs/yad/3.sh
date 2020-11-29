#!/usr/bin/env bash

disk="$1"

output=$(yad --text "Raspbian Image eg.2020-raspbian.img" --text-align=center --form --field="Raspbian Image:SFL")
buttonpressed=$?

if [ $buttonpressed -eq 0 ];
then
raspbianimg=$(echo $output|sed  's/|//')
echo multipi4-preparedisk "$raspbianimg" "disk"
else
exit 1
fi
