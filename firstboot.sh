#!/bin/bash

sudo systemctl disable networking
sudo systemctl enable OS-CHOOSER
sudo systemctl disable dhcpcd
sudo reboot
