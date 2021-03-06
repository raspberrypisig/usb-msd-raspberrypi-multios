set -x

disk="$1"

declare -A ary

basedistros=

while IFS== read -r key value; do
  ary["$key"]="$value"
  basedistros+="${key}\!"
done < basedistros.txt

basedistros=${basedistros::-1}

output="$(yad --width=600 --center --height=400 --buttons-layout=center --title="Multipi4 - Add OS" --text="Add OS" \
--image="/usr/share/icons/Tango/scalable/emotes/face-smile.svg" \
--form  \
--field=Name "" \
--field="Base distro":CB \
"$basedistros" \
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
#echo $name
#echo $basedistro
#echo $image
#bash multipi4 "$basedistro" "$image" "$disk" "$name" 
gnome-terminal --wait -- bash ./multipi4 ${ary["$basedistro"]} "$image" "$disk" "$name"
status=$?
if [ $status -eq 0 ];
then
  echo "Finished."
  
else
  echo "Something went wrong."
fi

pipefile=/tmp/multip4.fifo
#echo -e "\f" > $pipefile &
mkdir -p /tmp/multipi4/distros
mount ${disk}2 /tmp/multipi4/distros
oslist=$(cat /tmp/multipi4/distros/oslist.txt)
umount ${disk}2
(
echo -e "\f" > /tmp/multipi4.fifo
echo -e "$oslist" > /tmp/multipi4.fifo
)
echo [info] Sleep for 20 seconds
sleep 20
exit 0
else
exit 1
fi
