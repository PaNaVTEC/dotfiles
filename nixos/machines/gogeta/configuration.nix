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

  hardware = {
    enableRedistributableFirmware = true;
    ledger.enable = true;
    logitech.wireless.enable = true;
  };

  environment.etc."docker-daemon.json".text = ''{"data-root": "/run/media/panavtec/099a0278-856c-450c-af43-fe601c952d24/docker-data-root"}'';

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
