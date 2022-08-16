{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./networking.nix
      ./i3.nix
      ./urxvt.nix
      ./fonts.nix
      ./apps.nix
      ./development.nix
      ./security.nix
      ./web-browsers.nix
      ./cli.nix
      ./messaging.nix
      ./audio.nix
      ./users.nix
      ./bluetooth.nix
    ];

  time.timeZone = "Europe/Madrid";
  i18n.extraLocaleSettings = {
    LC_TIME = "es_ES.UTF-8";
  };

  systemd.services.systemd-udev-settle.enable = lib.mkForce false;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      stable = import <stable> {
        config = config.nixpkgs.config;
      };
      # sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
      unstable = import <unstable> {
        config = config.nixpkgs.config;
      };
      amazon-corretto17 = pkgs.callPackage ./pkgs/amazon-corretto17 {};
    };
  };

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

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
