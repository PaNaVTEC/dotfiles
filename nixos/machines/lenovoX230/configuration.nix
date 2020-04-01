{ config, pkgs, ... }:

{
	imports =
		[
			../../common.nix
      /etc/nixos/hardware-configuration.nix
		];

  networking.hostName =  "lenovox230-nix";

  # SSD options
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
    };
    initrd.luks.devices = [
      {
        name = "root";
        # blkid gives you back the disk id
        device = "/dev/disk/by-uuid/ab20dece-a988-4943-9327-28c1aca33e8c";
        preLVM = true;
        allowDiscards = true;
      }
    ];
  };

}
