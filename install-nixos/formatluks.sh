#!/bin/bash
set -e
set -x

passphrase="${passphrase:-NONE}"

echo "Creating the encrypted partition, follow the instructions and use a strong passphrase!"

echo "YES" | cryptsetup luksFormat /dev/disk/by-partlabel/cryptroot
cryptsetup luksOpen /dev/disk/by-partlabel/cryptroot enc-pv

# Create only a drive (no swap) with 100% space
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -l '100%FREE' -n root vg

mkfs.ext4 -L root /dev/vg/root

mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/disk/by-partlabel/efiboot /mnt/boot

exit 0
