#!/usr/bin/env bash
set -x

setup() {
  usbdevice="$1"
  raspbianliteimg="$2"

  loopdevice=$(losetup --show -Pf "$raspbianliteimg")
  mkdir -p raspbianboot
  mkdir -p raspbian
  mkdir -p {usb1,usb2,usb3}
  mount -o ro ${loopdevice}p1 raspbianboot
  mount -o ro ${loopdevice}p2 raspbian
  mount ${usbdevice}1 usb1
  mount ${usbdevice}2 usb2
  mount ${usbdevice}3 usb3

  cp -r raspbianboot/* usb1/
  rsync -a raspbian/ usb3/
  wget -O usb3/etc/fstab https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/fstab
  wget https://github.com/raspberrypi/rpi-eeprom/releases/download/v2020.05.28-137ad/usb-msd-boot-firmware.zip
  unzip -o -d usb1 usb-msd-boot-firmware.zip
  wget -O usb1/config.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/partition1/config.txt
  wget -O usb1/cmdline.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/cmdline.txt
  cp -r usb1/* usb2/
  wget -O usb2/config.txt https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/partition2/config.txt
  wget -O usb3/OS-CHOOSER.sh https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/OS-CHOOSER.sh
  chmod +x usb3/OS-CHOOSER.sh
  wget -O usb3/etc/systemd/system/oschooser.service https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/oschooser.service
  wget -O usb3/firstboot.sh https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/firstboot.sh
  chmod +x usb3/firstboot.sh
  cp usb3/etc/rc.local usb3/etc/rc.local.original
  echo -e "#!/usr/bin/env bash\n/firstboot.sh\nexit0" > usb3/etc/rc.local

  umount {usb1,usb2,usb3,raspbianboot,raspbian}
  losetup -D $loopdevice
}


fromimg() {
  osimg="$1"
  bootpart="$2"
  linuxpart="$3"
  name="$4"



  loopdevice=$(losetup --show -Pf "$osimg")
  mkdir -p osboot
  mkdir -p os
  mkdir -p usbboot
  mkdir -p usblinux
  mount -o ro ${loopdevice}p1 osboot
  mount -o ro ${loopdevice}p2 os
  mount $bootpart usbboot
  mount $linuxpart usblinux

  cp -r ./osboot/* usbboot/
  rsync -a os/ usblinux/
  wget -O usblinux/etc/fstab https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/fstab
  #escaped_bootpart=$(sed 's/\//\\\//g' <<< $bootpart)
  #escaped_linuxpart=$(sed 's/\//\\\//g' <<< $linuxpart)
  bootpartnumber="${bootpart//[^0-9]}"
  linuxpartnumber="${linuxpart//[^0-9]}"
  sed -i -r "s/\/dev\/sda1/\/dev\/sda$bootpartnumber/" usblinux/etc/fstab
  sed -i -r "s/\/dev\/sda3/\/dev\/sda$linuxpartnumber/" usblinux/etc/fstab
  echo "$name" > usbboot/NAME

  umount {usbboot,usblinux,osboot,os}
  losetup -D $loopdevice
}

fromsd() {
  sd="$1"
  bootpart="$2"
  linuxpart="$3"
  name="$4"

  mkdir -p osboot
  mkdir -p os
  mkdir -p usbboot
  mkdir -p usblinux
  mount -o ro ${sd}p1 osboot
  mount -o ro ${sd}p2 os
  mount $bootpart usbboot
  mount $linuxpart usblinux

  cp -r ./osboot/* usbboot/
  rsync -a os/ usblinux/
  wget -O usblinux/etc/fstab https://github.com/raspberrypisig/usb-msd-raspberrypi-multios/raw/master/fstab
  #escaped_bootpart=$(sed 's/\//\\\//g' <<< $bootpart)
  #escaped_linuxpart=$(sed 's/\//\\\//g' <<< $linuxpart)
  bootpartnumber="${bootpart//[^0-9]}"
  linuxpartnumber="${linuxpart//[^0-9]}"
  sed -i -r "s/\/dev\/sda1/\/dev\/sda$bootpartnumber/" usblinux/etc/fstab
  sed -i -r "s/\/dev\/sda3/\/dev\/sda$linuxpartnumber/" usblinux/etc/fstab
  echo "$name" > usbboot/NAME

  umount {usbboot,usblinux,osboot,os}
}

ubuntufromimg() {
  osimg="$1"
  bootpart="$2"
  linuxpart="$3"
  name="$4"

  loopdevice=$(losetup --show -Pf "$osimg")
  mkdir -p osboot
  mkdir -p os
  mkdir -p usbboot
  mkdir -p usblinux
  mount -o ro ${loopdevice}p1 osboot
  mount -o ro ${loopdevice}p2 os
  mount $bootpart usbboot
  mount $linuxpart usblinux

  cp -r ./osboot/* usbboot/
  rsync -a os/ usblinux/
  touch usblinux/etc/cloud/cloud-init.disabled
cat <<EOF > usbboot/config.txt
[all]
device_tree_address=0x03000000
kernel=vmlinuz
initramfs initrd.img followkernel
EOF

  bootpartnumber="${bootpart//[^0-9]}"
  linuxpartnumber="${linuxpart//[^0-9]}"
  sed -i -r "s/LABEL=system-boot/\/dev\/sda$bootpartnumber/" usblinux/etc/fstab
  sed -i -r "s/LABEL=writable/\/dev\/sda$linuxpartnumber/" usblinux/etc/fstab
  echo "$name" > usbboot/NAME
  umount {usbboot,usblinux,osboot,os}
  losetup -D $loopdevice                                                
}



case "$1" in
  "setup")
    shift
    setup "$@"
   ;;
  "add")
    shift
    case "$1" in
      "fromimg")
        shift
        fromimg "$@"
        ;;
      "fromsd")
        shift
        fromsd "$@"
        ;;
    esac
   ;;
  "addubuntu")
    shift
    ubuntufromimg "$@"
  ;;
  *)
    echo help
    ;;


esac
