----/multipi4
--------buildroot-2020.05
--------multipi4


chmod -R -w /multipi4/buildroot-2020.05
cd /multipi4/buildroot-2020.05
make O=../multipi4 raspberrypi4_defconfig
cd ../multipi4
make menuconfig
make linux-menuconfig
make busybox-menuconfig
make
