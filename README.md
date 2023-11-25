# dotfiles based on nixos

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

