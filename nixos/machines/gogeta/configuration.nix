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
  services.xserver.videoDrivers = [ "amdgpu" ];

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-partlabel/data";
    options = [ "uid=1000" "gid=1000" "dmask=007" "fmask=117" ];
  };

  boot = {
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
