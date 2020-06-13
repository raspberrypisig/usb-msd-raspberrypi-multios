# usb-msd-raspberrypi-multios

On my 2TB hard drive, have these partitions:

FAT 32 Partions

1. root=/dev/sda12
2. root=/dev/sda13
3.
4.
5.
6.
7.
8.
9.
10.

NTFS Partition
11.


EXT4 Partition

12. Raspberry Pi OS Lite - contains OS-CHOOSER.sh (use code from OS-CHOOSER-improved)
13. Raspberry Pi OS Desktop - Bookshelf
14. Home Assistant - Raspberry Pi OS Desktop
15. Twister OS
16. Raspberry Pi OS Lite - running repairs
17. Kali OS


# Problems

1. Can't reboot to partition number 5 and above, so using partition 4 as a sacrificial partition. When selecting an OS
from menu, I change root=/dev/sda{root_part} in cmdline.txt on /dev/sda4 and "reboot 4 "

# Strategy
Create a NAME file in the fat partition with the name of the Distro.
If partition number < 4, then do reboot <boot_part>. Else do as stated in problem 1.


