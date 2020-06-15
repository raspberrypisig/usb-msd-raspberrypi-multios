#!/bin/bash

sudo systemctl disable networking
sudo systemctl enable OS-CHOOSER
sudo systemctl disable dhcpcd
sudo systemclt disable rpi-eeprom-update
sudo reboot
