#!/usr/bin/env bash
set -x

LATEST_VERSION='2020.08'
wget https://buildroot.org/downloads/buildroot-$LATEST_VERSION.tar.gz
tar xvzf buildroot-$LATEST_VERSION.tar.gz
rm buildroot-$LATEST_VERSION.tar.gz
