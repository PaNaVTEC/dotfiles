# dotfiles based on nixos

NixOS upgrades

## Upgrade

```
sudo nix-channel --list | grep nixos
```

To upgrade:

```
nix-channel --add https://channels.nixos.org/nixos-23.05 nixos
```
or to unstable:

```
nix-channel --add https://channels.nixos.org/nixos-unstable nixos
```

Update as well `users.nix` with the same version of the channel for home-manager. And then:

```
nixos-rebuild switch --upgrade
```

# Disk migration - Move to a new disk

- Use clonezilla to clone the drive
- In the new booted linux system, use gparted to extend the encrypted partition
- After that you need to resize the lvm volume which is part of the encrypted partition, to do so:

```
sudo lvdisplay # This is to get the mountpoint, although it usually is /dev/vg/root
sudo lvextend –l +100%FREE [MOUNTPOINT]
sudo resize2fs [MOUNTPOINT]
```

The new disk will have the new size of the disk
