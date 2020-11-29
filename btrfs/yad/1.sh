#!/usr/bin/env bash

#LIST="one\ntwo\nthree"
# echo -e "$LIST"
output="$(bash diskinfo.sh | yad --center --borders=30 --title='Pi-Apps' --width=600 --height=400 --no-headers --buttons-layout=center  \
        --text="\nPlease select drive to make into a multiboot Pi disk\n" --text-align=center  \
        --list --separator='\n'  \
        --column=:Name --print-column=1 \
        --button=Select:0 \
        --button=Cancel:1 \
        )"

buttonpressed=$?
if [ $buttonpressed -eq 0  ];
then
#echo $output
disk=$(echo $output | cut -f1 -d':')
bash 2.sh $disk
else
exit 1
fi
