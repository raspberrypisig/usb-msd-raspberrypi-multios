#!/bin/bash

sudo systemctl disable networking
sudo systemctl enable OS-CHOOSER
sudo systemctl disable dhcpcd
sudo systemctl disable rpi-eeprom-update
sudo systemctl disable avahi-daemon
sudo systemctl mask raspi-config
sudo systemclt disable dphys-swapfile
sudo reboot
