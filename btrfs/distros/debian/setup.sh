#!/usr/bin/env bash
set -x

volname="$1"

sed -i "s/PLACEHOLDER/$volname/" /boot/firmware/cmdline.txt 
sed -i "s/PLACEHOLDER/$volname/" /etc/fstab

VERSION=$(find /lib/modules -name *-arm64 -exec basename {} \; )

apt-mark hold linux-image-$VERSION
apt update
apt install -y task-kde-desktop




