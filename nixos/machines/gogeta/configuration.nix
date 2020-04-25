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

  # fixes GPU
  hardware.enableRedistributableFirmware = true;
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    xrandrHeads = [
      "DisplayPorts"
      {
        output = "DisplayPort-3";
        monitorConfig = ''
          Option "Rotate" "left"
          Option "PreferredMode" "1920x1080"
          Option "Position" "0 0"
        '';
      }
      {
        output = "DisplayPort-0";
        primary = true;
        monitorConfig = ''
          Option "Position" "1080 0"
          Option "PreferredMode" "3840x2160"
        '';
      }
    ];
#    resolutions = [
#      { x = 2048; y = 1152; }
#      { x = 1920; y = 1080; }
#    ];
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
  ];

  boot = {
    kernelModules = [
      "kvm-amd" # enables virtualization
      "nct6775" # enables cpu sensors
    ];

    loader = {
      # It does not really disable systemd, after turning on grub you have to
      # change the bios configuration and select:
      # "NixOS boot" over "Linux boot manager"
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        version = 2;
        # FE5E-1305 is the partition UUID got from running 'sudo blkid'
        # and represents the boot EFI partition of Windows
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root FE5E-1305
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
      '';
      };
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
