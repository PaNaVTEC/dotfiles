{ config, pkgs, ... }:

{
  imports =
    [
      ../../common.nix
      /etc/nixos/hardware-configuration.nix
    ];

  networking = {
    hostName = "mVTEC";
    useDHCP = false;
#    interfaces.enp0s20f0u3.useDHCP = true;
#    interfaces.wlp2s0.useDHCP = true;
  };

  programs.light.enable = true;
  hardware.bumblebee.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/c32cf841-2d15-471e-849b-fe1796575e6e";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
