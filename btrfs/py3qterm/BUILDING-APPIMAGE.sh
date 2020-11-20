#!/usr/bin/env bash

apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev fakeroot subversion git
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
chmod +x /usr/local/bin/appimagetool
pip3 install git+https://github.com/AppImageCrafters/appimage-builder.git
svn co https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/trunk/btrfs/py3qterm/AppImageBuild
cd AppImageBuild
appimage-builer --skip-tests

