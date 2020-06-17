# Create a Homebrew Multiboot USB/SSD for Raspberry Pi 4

THIS PROCEDURE IS EXTREMELY DANGEROUS. 

PARTICULAR CARE SHOULD BE TAKEN WHEN SPECIFIYING DISKS AND PARTITIONS.

IT IS EASY TO GET IT WRONG, RESULTING IN LOSS OF DATA. 

TRIPLE-CHECK. YOU HAVE BEEN WARNED.

### Prerequisities

1.  Raspberry Pi 4 with the lastest USB MSD bootloader (as time of writing 16 June), can be obtained from [here](https://github.com/raspberrypi/rpi-eeprom/blob/master/releases.md)
2. External USB3 hard drive/SSD

### Steps

1. Create an empty directory where the fun happens and cd into the directory.
2. Need access to uncompressed copies of Raspberry Pi OS Lite and Raspberry Pi OS Desktop images.
3. Setup of first three partitions(partition 1 FAT32, partition 2 FAT32, partition 3 ext4) 

```sh
wget https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/multipi4.sh
chmod +x https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/multipi4.sh
./multipi4.sh setup /dev/sdc /media/demo/sdb1-ata-Samsung_Portable/2020-05-27-raspios-buster-lite-armhf.img
```
4. Add an OS (in this case Raspberry Pi OS Desktop on partition 4(FAT32) and partition 5(ext4)

```sh
./multipi4.sh addos /media/demo/sdb1-ata-Samsung_Portable/2020-05-27-raspios-buster-armhf.img /dev/sdc4 /dev/sdc5 "Raspberry Pi OS Desktop"
```



