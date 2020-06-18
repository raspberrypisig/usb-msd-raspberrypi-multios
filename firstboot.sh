#!/bin/bash

services_disable=( "networking" "dhcpcd" "rpi-eeprom-update" "avahi-daemon" "dphys-swapfile" "wpa_supplicant" "rc-local" )
services_enable=( "oschooser" )
services_mask=( "raspi-config" )

for service in "${services_disable[@]}"
do
  systemctl disable $service
done

for service in "${services_enable[@]}"
do
  systemctl enable $service
done

for service in "${services_mask[@]}"
do
  systemctl mask $service
done

mv /etc/rc.local.original /etc/rc.local
sudo reboot
