{ config, pkgs, ... }:

{
  imports =
    [
      ../../common.nix
      /etc/nixos/hardware-configuration.nix
    ];

  networking.hostName =  "nuc-nix";

  # SSD options
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
    };
    initrd.luks.devices = [
      {
        name = "root";
        # blkid gives you back the disk id
        device = "/dev/disk/by-uuid/b9d4779c-0148-4c33-9048-842f32efca8a";
        preLVM = true;
        allowDiscards = true;
      }
    ];
  };

  services.xserver.xrandrHeads = [
    "DP1"
    {
      output = "DP2";
      primary = true;
    }
    {
      output = "HDMI2";
      monitorConfig = "Option \"Rotate\" \"left\"";
    }
  ];

}
