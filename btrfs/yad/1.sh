#!/usr/bin/env bash

LIST="one\ntwo\nthree"
output="$(echo -e "$LIST" | yad --center --title='Pi-Apps' --width=600 --height=400 --no-headers \
        --text="\nPlease select drive to make into a multiboot Pi disk\n" --text-align=center  \
        --list --multiple --separator='\n'  \
        --column=:Name --print-column=1 \
        --button=Select:0 \
        --button=Cancel:1 \
        )"
buttonpressed=$?
echo $buttonpressed
