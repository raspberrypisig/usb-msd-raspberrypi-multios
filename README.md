# usb-msd-raspberrypi-multios

Use GParted to partition disks (I am using GPT).


First 3 partitions are "special".
Subsequently, each OS that you want to add is a {FAT32, ext4} pair.

ie:

PARTITION 1:
PARTITION 2:
PARTITION 3:

To add Raspberry PI OS Desktop as first OS

PARTITION 4: FAT32 boot paritition of Raspberry PI OS Desktop
PARTITION 5: Ext3/4 partition of Raspberry PI OS Desktop

# OS Changes

You will need to alter each OS image you add.

FAT32 changes

* Create a file called NAME with the name you would like to appear in the OS selection menu

EXT4 changes

* change /etc/fstab to use the correct partitions for / and /boot


# Problems

1. Can't reboot to partition number 5 and above, so using partition 4 as a sacrificial partition. When selecting an OS
from menu, I change root=/dev/sda{root_part} in cmdline.txt on /dev/sda4 and "reboot 4 "

# Strategy
Create a NAME file in the fat partition with the name of the Distro.
If partition number < 4, then do reboot <boot_part>. Else do as stated in problem 1.

# Commands

losetup --show -Pf 2020-raspbian.img
mkdir /raspbian
mkdir /raspbianboot
mount -o ro /dev/loop1p1 /raspbianboot
mount -o ro /dev/loop1p2 /raspbian
cp -rv /raspbianboot/* /media/sdb1/
rsync -avu /raspbian/ /media/sdb12/

findmnt /
findmnt /boot




