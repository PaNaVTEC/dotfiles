{ config, pkgs, ... }:

{

  nix.nixPath = ["/home/carlos/.nix-defexpr/channels:nixpkgs=/home/carlos/.nixpkgs-unstable-custom/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels:stable=/nix/var/nix/profiles/per-user/root/channels/stable/nixpkgs"];

  imports =
    [
      ./networking.nix
      ./i3.nix
      ./urxvt.nix
      ./fonts.nix
      ./apps.nix
      ./emacs.nix
      ./scala.nix
      ./java.nix
      ./haskell.nix
      ./git.nix
      ./virtualization.nix
      ./containerization.nix
      ./security.nix
      ./web-browsers.nix
      ./golang.nix
      ./cli.nix
      ./messaging.nix
      ./audio.nix
      ./python.nix
      ./javascript.nix
      ./users.nix
      ./bluetooth.nix
    ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search

  environment.systemPackages = with pkgs; [
    wget vim htop imagemagick gnumake binutils
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    exportConfiguration = true;
  };

  security.sudo.configFile = "%wheel ALL=(ALL) ALL";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      stable = import <stable> {
        config = config.nixpkgs.config;
      };
    };
  };
  nixpkgs.overlays = import ./overlays/default.nix;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system = {
    stateVersion = "18.03"; # Did you read the comment?
    autoUpgrade.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
