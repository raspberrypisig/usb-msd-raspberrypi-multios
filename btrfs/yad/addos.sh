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
#echo $output
name=$(echo $output | cut -f1 -d'|')
basedistro=$(echo $output | cut -f2 -d'|')
image=$(echo $output | cut -f3 -d'|')
echo $name
echo $basedistro
echo $image
#bash multipi4 "$basedistro" "$image" "$disk" "$name" 
gnome-terminal --wait -- bash ./multipi4 "$basedistro" "$image" "$disk" "$name"
status=$?
if [ $status -eq 0 ];
then
  echo "Finished."
  
else
  echo "Something went wrong."
fi

bash main.sh $disk

else
exit 1
fi

