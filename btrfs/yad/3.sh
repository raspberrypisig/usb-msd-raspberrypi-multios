#!/usr/bin/env bash
set -x
disk="$1"

output=$(yad --text "Raspbian Image eg.2020-raspbian.img" --text-align=center --form --field="Raspbian Image:SFL")
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



else
exit 1
fi
