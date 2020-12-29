#!/usr/bin/env bash
set -x

TEMP_BOOT=/tmp/multipi4/alpine
rm -rf $TEMP_BOOT
mkdir -p $TEMP_BOOT
cp localhost.apkovl.tar.gz container.sh rebootp.c inittab menu.sh oschooser.sh $TEMP_BOOT
cd $TEMP_BOOT

wget -O alpine-rpi.tar.gz -c https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/aarch64/alpine-rpi-3.12.3-aarch64.tar.gz
wget -O alpine-miniroot.tar.gz -c https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/aarch64/alpine-minirootfs-3.12.3-aarch64.tar.gz
mkdir -p miniroot rpi
tar xvzf alpine-rpi.tar.gz -C rpi
tar xvzf alpine-miniroot.tar.gz -C miniroot
rm alpine-rpi.tar.gz
rm alpine-miniroot.tar.gz

cp container.sh rebootp.c miniroot
systemd-nspawn -D miniroot /container.sh
rm miniroot/container.sh
cp -v miniroot/root/*.apk rpi/apks/aarch64
cp -v localhost.apkovl.tar.gz rpi/
mkdir rpi/multipi4
cp $TEMP_BOOT/{inittab,menu.sh,oschooser.sh} rpi/multipi4
cp miniroot/rebootp.bin rpi/multipi4


