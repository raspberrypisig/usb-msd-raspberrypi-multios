#!/usr/bin/env sh
set -x
cd /root
apk update
apk add gcc linux-headers
apk fetch -R bash newt
gcc -static -o /rebootp /rebootp.c

