#!/usr/bin/env sh
set -x
cd /root
apk update
apk add gcc linux-headers alpine-sdk
apk fetch -R bash newt
gcc -static -o /rebootp.bin /rebootp.c

