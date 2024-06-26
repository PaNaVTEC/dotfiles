{ ... }:

{
  imports =
    [
      ../../common.nix
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "goku-nixos";
    useDHCP = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    ledger.enable = true;
    cpu.amd.updateMicrocode = true;
  };

  boot = {
    kernelModules = [
      "kvm-amd" # enables virtualization
    ];

    loader = {
      systemd-boot = {
        configurationLimit = 5;
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      luks.devices = {
        root = {
         device = "/dev/disk/by-uuid/d667c28b-2168-4c4f-b6f1-3d75b3f51c76";
         preLVM = true;
         allowDiscards = true;
        };
      };
    };
  };
}
