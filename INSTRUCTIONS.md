# Create a Homebrew Multiboot USB/SSD for Raspberry Pi 4

THIS PROCEDURE IS EXTREMELY DANGEROUS. 

PARTICULAR CARE SHOULD BE TAKEN WHEN SPECIFIYING DISKS AND PARTITIONS.

IT IS EASY TO GET IT WRONG, RESULTING IN LOSS OF DATA. 

TRIPLE-CHECK. YOU HAVE BEEN WARNED.

### Prerequisities

1.  Raspberry Pi 4 with the lastest USB MSD bootloader (as time of writing 16 June), can be obtained from [here](https://github.com/raspberrypi/rpi-eeprom/blob/master/releases.md)
2. External USB3 hard drive/SSD
3. Run commands as root (sudo su) in an EMPTY DIRECTORY 

### Steps

1. Create an empty directory where the fun happens and cd into the directory.
2. Need access to uncompressed copies of Raspberry Pi OS Lite and Raspberry Pi OS Desktop images.
3. Install multip4 

```sh
wget -O /usr/local/bin/multipi4 https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/multipi4
chmod +x /usr/local/bin/multipi4
```

4. Setup of first three partitions(partition 1 FAT32, partition 2 FAT32, partition 3 ext4) 

```sh
fdisk -l
multipi4 setup /dev/sdc /media/demo/sdb1-ata-Samsung_Portable/2020-05-27-raspios-buster-lite-armhf.img
```
5. 

In the following, want to install on partition 4 (FAT32) and partition 5 (ext4)

(i) OPTION 1

Add Raspberry Pi OS from a disk image (in this case Raspberry Pi OS Desktop on partition 4(FAT32) and partition 5(ext4)

```sh
fdisk -l
multipi4 add fromimg /media/demo/sdb1-ata-Samsung_Portable/2020-05-27-raspios-buster-armhf.img /dev/sdc4 /dev/sdc5 "Raspberry Pi OS Desktop"
```

(ii) OPTION 2

Add Raspberry Pi OS from a OS on an existing SD card 

```sh
fdisk -l
multipi4 add fromsd /dev/mmcblk0 /dev/sdc4 /dev/sdc5 "Raspberry Pi OS Desktop"
```

(iii) OPTION 3

Add Ubuntu 20.04 from a disk image

```sh
multipi4 addubuntu /media/demo/sdb1-ata-Samsung_Portable/2020-05-27-raspios-buster-armhf.img /dev/sdc4 /dev/sdc5 "Ubuntu 20.04"
```



