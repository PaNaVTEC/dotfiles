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
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    monitorSection = ''
      Option "DPI" "96x96"
      Option "UseEdidDpi" "FALSE"
    '';
    xrandrHeads = [
#      {
#        output = "HDMI-1";
#        monitorConfig = ''
#          Option "Rotate" "left"
#          Option "PreferredMode" "1920x1080"
#          Option "Position" "0 0"
#        '';
#      }
      {
        output = "DP-0";
        primary = true;
        monitorConfig = ''
          Option "Position" "0 0"
          Option "PreferredMode" "3840x2160"
          ModelName      "LG Electronics LG HDR 4K"
          HorizSync       135.0 - 135.0
          VertRefresh     48.0 - 61.0
          Option         "DPMS"
        '';
      }
    ];
  };

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-label/data-samsung";
      fsType = "ntfs";
      options = [ "defaults" "uid=1000" "nofail" ];
    };

    "/mnt/data2" = {
      device = "/dev/disk/by-label/BACKUP";
      fsType = "vfat";
      options = [ "defaults" "uid=1000" "nofail" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # ICC monitor color management
    argyllcms

    # cue-like software
    openrgb
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
