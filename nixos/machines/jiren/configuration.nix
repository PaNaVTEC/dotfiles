{ config, pkgs, ... }:

{
  imports =
    [
      ../../common.nix
      /etc/nixos/hardware-configuration.nix
    ];

  networking = {
    hostName = "jiren-nixos";
    useDHCP = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    ledger.enable = true;
    logitech.wireless.enable = true;

    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };

  boot = {
    kernelModules = [
      "kvm-amd" # enables virtualization
      "amdgpu"
    ];

    loader = {
      systemd-boot = {
        configurationLimit = 20;
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/a515435b-7a40-4a04-af37-ba2d4340899e";
        preLVM = true;
        allowDiscards = true;
      };
    };
  
  };
}