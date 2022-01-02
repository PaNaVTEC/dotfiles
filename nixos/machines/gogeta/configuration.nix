{ config, pkgs, ... }:

{
  imports =
    [
      ../../common.nix
      /etc/nixos/hardware-configuration.nix
    ];

  networking = {
    hostName = "gogeta-nixos";
    useDHCP = false;
  };

  hardware.enableRedistributableFirmware = true;

  #services.udev.extraRules = "SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2c97\", ATTRS{idProduct}==\"4011\", TAG+=\"uaccess\", TAG+=\"udev-acl\"\n";
  hardware.ledger.enable = true;

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    xrandrHeads = [
      {
        output = "HDMI-A-0";
        monitorConfig = ''
          Option "PreferredMode" "5120x1440"
          Option "Position" "0 0"
        '';
      }
    ];
  };

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-label/data-samsung";
      fsType = "ntfs";
      options = [ "rw" "defaults" "uid=1000" "nofail" ];
    };
    "/mnt/music" = {
      device = "/dev/disk/by-uuid/8631-05AC";
      options = [ "defaults" "uid=1000" "nofail" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # ICC monitor color management
    argyllcms
  ];

  boot = {
    kernelModules = [
      "kvm-amd" # enables virtualization
      "nct6775" # enables cpu sensors
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/743ed7b2-82b2-4cd7-9cb3-9ef4b78fca72";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
