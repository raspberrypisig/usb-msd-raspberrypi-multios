#!/usr/bin/env bash

usb_disk="$1"

echo 'label: gpt' | sfdisk $usb_disk 
