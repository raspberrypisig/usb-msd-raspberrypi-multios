
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY <program>

mkfifo boo

echo -e "\f\nOne\Two\nThreee" > boo

tail -f boo|yad --list  --column="Name" --print-all

# Supported OSes

- Raspberry Pi OS Buster (https://raspberrypi.org/software)
- Ubuntu 20.10 (https://ubuntu.com/download/raspberry-pi)
- CentOS (https://people.centos.org/pgreco/CentOS-Userland-8-stream-aarch64-RaspberryPI-Minimal-4/)