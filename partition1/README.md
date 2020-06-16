```sh
losetup --show -Pf 2020-05-27-raspios-buster-lite-armhf.img
mkdir /raspbian
mkdir /raspbianboot
mount -o ro /dev/loop1p1 /raspbianboot
mount -o ro /dev/loop1p2 /raspbian
cp -rv /raspbianboot/* /media/sda1/
cp -rv /usbmsdboot/* /media/sda1
rsync -avu /raspbian /media/sda2
cp -rv /media/sda2 /media/sda3
```
