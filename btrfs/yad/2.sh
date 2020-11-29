#!/usr/bin/env bash
set -x
disk="$1"

output="$(yad --center --borders=10 \
         --text "You selected disk: ${disk}.\nData will be DESTROYED on disk.\nPress OK to proceed. Press cancel to exit. "
)"

buttonpressed=$?

if [ $buttonpressed -eq 0 ];
then
bash 3.sh $disk
else
exit 1
fi
