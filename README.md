# usb-msd-raspberrypi-multios

Use GParted to partition disks (I am using GPT).


First 3 partitions are "special".
Subsequently, each OS that you want to add is a {FAT32, ext4} pair.

ie:

PARTITION 1: Boot partition of Raspberry Pi OS Lite 

PARTITION 2: Ext4/linux paritition of Raspberry Pi OS Lite

PARTITION 3:  Same as contents of Partition 1, ie boot partition of Raspberry Pi OS Lite 

To add Raspberry PI OS Desktop as first OS

PARTITION 4: FAT32 boot paritition of Raspberry PI OS Desktop

PARTITION 5: Ext3/4 partition of Raspberry PI OS Desktop

# Preparing the special partitions

The first three partitions are special partitions. Special partitions don't have a file called NAME.

### Partition 1 

* Grab script from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/OS-CHOOSER.sh)
  and put in /OS-CHOOSER.sh
* Grab script from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/oschooser.service)
  and put in /etc/systemd/system 
* Grab script from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/firstboot.sh) and
  put in /firstboot.sh 
* Change cmdline.txt so that root=/dev/sda2
* When you first boot to this partition, run

  ```sh
  bash /firstboot.sh
  ```

### Partition 2

* Change /etc/fstab 

### Partition 3

* Change config.txt

# OS Changes

You will need to alter each OS image you add.

FAT32 changes

* Create a file called NAME with the name you would like to appear in the OS selection menu

EXT4 changes

* change /etc/fstab to use the correct partitions for / and /boot


# How it works

# My custom setup

I have a 2TB external USB3 hard drive.


# Problems

1. Can't reboot to partition number 5 and above, so using partition 4 as a sacrificial partition. When selecting an OS
from menu, I change root=/dev/sda{root_part} in cmdline.txt on /dev/sda4 and "reboot 4 "

# Useful Linux commands

```sh
losetup --show -Pf 2020-raspbian.img
mkdir /raspbian
mkdir /raspbianboot
mount -o ro /dev/loop1p1 /raspbianboot
mount -o ro /dev/loop1p2 /raspbian
cp -rv /raspbianboot/* /media/sdb1/
rsync -avu /raspbian/ /media/sdb12/
findmnt /
findmnt /boot
```



