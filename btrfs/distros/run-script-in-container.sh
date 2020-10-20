apt install -y binfmt-support qemu-user-static systemd-container

script="$1"
mount_dir="$2"

cp $script $mount_dir
systemd-nspawn -D $mount_dir /$script
