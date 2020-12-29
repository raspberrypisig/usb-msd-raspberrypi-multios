#!/bin/ash

# This file lives in /etc/local.d/menu.sh inside localhost.apkovl.tar.gz

cd /media/usb/apks/aarch64
apk add --force-non-repository --allow-untrusted ./popt-*apk ./pcre-*.apk ./ncurses-*.apk ./readline-*.apk ./slang-*.apk ./bash-*.apk ./newt-*.apk
/etc/local.d/oschooser.sh