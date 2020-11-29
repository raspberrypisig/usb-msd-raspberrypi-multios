#!/usr/bin/env bash
set -x
disk="$1"

partitions=$(fdisk -l  $disk | sed -n '/Type/,$p'|sed -n '2,$p'|awk '{print $1}')
#echo "$partitions"
numberofpartitions=$(echo -en "$partitions" | wc -l)
numberofpartitions=$(( numberofpartitions + 1  ))
#echo $numberofpartitions

if [ $numberofpartitions -ne 3 ];
then
exit 1
fi

partitiontypes=$(blkid|grep $disk|sed -r 's/.*TYPE="([^"]*)(.*)/\1/')
readarray -t parray <<<$partitiontypes
#declare -p parray

existingtypes=("vfat" "vfat" "btrfs")
A=${partitiontypes[@]}
B=${existingtypes[@]}

if [ "$A" != "$B"  ];
then
exit 1
fi
