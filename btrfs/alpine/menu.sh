#!/bin/ash

# This file lives in /etc/local.d/menu.sh inside localhost.apkovl.tar.gz

FIRST_PARTITION_MOUNT=$(grep /dev/sda1 /etc/mtab|cut -f2 -d' ')
#echo $FIRST_PARTITION_MOUNT
#sleep 60
cd $FIRST_PARTITION_MOUNT/apks/aarch64
apk add --force-non-repository --allow-untrusted ./popt-*apk ./pcre-*.apk ./ncurses-*.apk ./readline-*.apk ./slang-*.apk ./bash-*.apk ./newt-*.apk
/etc/local.d/oschooser.sh
