{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./networking.nix
      ./i3.nix
      ./urxvt.nix
      ./fonts.nix
      ./apps.nix
      ./emacs.nix
      ./java.nix
      ./git.nix
      ./virtualization.nix
      ./containerization.nix
      ./security.nix
      ./web-browsers.nix
      ./cli.nix
      ./messaging.nix
      ./audio.nix
      ./users.nix
      ./bluetooth.nix
    ];

  time.timeZone = "Europe/Madrid";

  environment.systemPackages = with pkgs; [
    wget vim htop imagemagick gnumake binutils
  ];

  systemd.services.systemd-udev-settle.enable = lib.mkForce false;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      stable = import <stable> {
        config = config.nixpkgs.config;
      };
    };
  };
  nixpkgs.overlays = import ./overlays/default.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "20.09"; # Did you read the comment?
    autoUpgrade.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
