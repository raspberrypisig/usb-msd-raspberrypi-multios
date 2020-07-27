#!/usr/bin/env bash
mkdir build
cd build
make BR2_EXTERNAL=../multipi4/ O=$PWD -C ../buildroot-2020.05/ raspberrypi4_defconfig
