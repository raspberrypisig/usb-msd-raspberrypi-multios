#!/bin/bash
sudo chmod +x /OS-CHOOSER.sh

services_disable=( "networking" "dhcpcd" "rpi-eeprom-update" "avahi-daemon" "dphys-swapfile" "wpa_supplicant" "rc-local" )
services_enable=( "oschooser" )
services_mask=( "raspi-config" )

for service in "${services_disable[@]}"
do
  sudo systemctl disable $service
done

for service in "${services_enable[@]}"
do
  sudo systemctl enable $service
done

for service in "${services_mask[@]}"
do
  sudo systemctl mask $service
done






sudo reboot
