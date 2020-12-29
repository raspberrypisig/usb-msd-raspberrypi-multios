#!/usr/bin/env sh
set -x
cd /root
apk update
apk fetch -R bash newt findmnt
gcc -static -o /rebootp /rebootp.c

