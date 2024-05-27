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
      ./audio.nix
      ./users.nix
      ./bluetooth.nix
      ./threedprinting.nix
    ];

  time.timeZone = "Europe/Madrid";
  i18n.extraLocaleSettings = {
    LC_TIME = "es_ES.UTF-8";
  };

  systemd.services.systemd-udev-settle.enable = lib.mkForce false;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;

    packageOverrides = pkgs: {
      stable = import <stable> {
        config = config.nixpkgs.config;
      };
      # sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable && nix-channel --update
      unstable = import <unstable> {
        config = config.nixpkgs.config;
      };
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };

    permittedInsecurePackages = [
      "electron-24.8.6"
      "nix-2.15.3"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "22.11"; # Did you read the comment?
    autoUpgrade.enable = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
