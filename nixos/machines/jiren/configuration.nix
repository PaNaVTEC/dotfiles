{ ... }:

{
  imports =
    [
      ../../common.nix
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "jiren-nixos";
    useDHCP = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    ledger.enable = true;
    logitech.wireless.enable = true;
    cpu.amd.updateMicrocode = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };

  services.hardware.openrgb.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

  boot = {
    kernelModules = [
      "kvm-amd"
    ];

    loader = {
      systemd-boot = {
        configurationLimit = 10;
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
