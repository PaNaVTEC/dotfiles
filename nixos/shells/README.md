## Opening a shell

Sample opening java8:
```
nix-shell ~/dotfiles/nixos/shells/java8.nix
```

## File not found when running a shell

Add the channel to your non-root user:

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
```
