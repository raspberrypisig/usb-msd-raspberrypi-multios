#!/usr/bin/env bash

wget -O alpine-rpi.tar.gz -c https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/aarch64/alpine-rpi-3.12.3-aarch64.tar.gz
wget -O alpine-miniroot.tar.gz -c https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/aarch64/alpine-minirootfs-3.12.3-aarch64.tar.gz
mkdir -p miniroot rpi
tar xvzf alpine-rpi.tar.gz -C rpi
tar xvzf alpine-miniroot.tar.gz -C miniroot

cp container.sh miniroot
systemd-nspawn -D miniroot /container.sh
rm miniroot/container.sh
cp -v miniroot/root/*.apk rpi/apks/aarch64
cp -v localhost.apkovl.tar.gz rpi/
