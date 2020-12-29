#!/usr/bin/env sh
set -x
cd /root
apk update
apk fetch -R bash newt sfdisk
