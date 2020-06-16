# Homebrew Multiboot external USB drive boot with Raspberry Pi 4

Use GParted to partition disks (Tested with GPT disk).

First 3 partitions are "special".
Subsequently, each OS that you want to add is a {FAT32, ext4} pair.

ie:

PARTITION 1: Boot partition of Raspberry Pi OS Lite 

PARTITION 2: Ext4/linux paritition of Raspberry Pi OS Lite

PARTITION 3:  Same as contents of Partition 1, ie boot partition of Raspberry Pi OS Lite 

To add Raspberry PI OS Desktop as first OS

PARTITION 4: FAT32 boot paritition of Raspberry PI OS Desktop

PARTITION 5: Ext3/4 linux partition of Raspberry PI OS Desktop

# Preparing the special partitions

The first three partitions are special partitions. Special partitions don't have a file called NAME.

### Partition 1 

* Grab config.txt from [here](https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/config.txt) and replace file on partition 3
* Grab cmdline.txt from [here](https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/cmdline.txt) and replace file on partition 1
* Extract files from [here](https://github.com/raspberrypi/rpi-eeprom/releases/download/v2020.05.28-137ad/usb-msd-boot-firmware.zip) and replace files on partition 1

### Partition 2

Same content as partition 1

### Partition 3

* Grab OS-CHOOSER.sh from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/OS-CHOOSER.sh) and place on partition 3
* Grab oschooser.service from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/oschooser.service)  and put in etc/systemd/system 
* Grab fstab from [here](https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/fstab) and replace file at etc/fstab
* Grab firstboot.sh from [here](https://raw.githubusercontent.com/raspberrypisig/usb-msd-raspberrypi-multios/master/firstboot.sh) and put on partition 3



# OS Changes

You will need to alter each OS image you add.

FAT32 changes

* Create a file called NAME with the name you would like to appear in the OS selection menu
* edit cmdline.txt

EXT4 changes
* Change /etc/fstab to use the correct partitions for / and /boot 

# First Time Boot

If all is setup properly, you should boot the first-time into Raspberry Pi OS Lite so that:

```
$ findmnt /
should see /dev/sda2

$ findmnt /boot
should see /dev/sda1
```

If you run the first-time boot script,

```sh
bash /firstboot.sh
```

Then subsequent boots into the operating system will automatically open the OS selection menu.

You may need to change keyboard layout using raspi-config

# How it works


# Useful Linux commands

```sh
losetup --show -Pf 2020-raspbian.img
mkdir /raspbian
mkdir /raspbianboot
mount -o ro /dev/loop1p1 /raspbianboot
mount -o ro /dev/loop1p2 /raspbian
cp -rv /raspbianboot/* /media/sdb4/
rsync -avu /raspbian/ /media/sdb5/
findmnt /
findmnt /boot
```



