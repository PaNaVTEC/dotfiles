{ config, pkgs, ... }:

let
  userModule = (import ./user.nix);
  username = userModule.name;
  hostname = userModule.hostname;
  rootPartitionUUID = userModule.rootPartitionUUID;
in
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./i3.nix
      ./urxvt.nix
      ./fonts.nix
      ./apps.nix
      ./emacs.nix
      ./scala.nix
      ./java.nix
      ./git.nix
      ./virtualization.nix
      ./containerization.nix
    ];

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
        device = "/dev/disk/by-uuid/${rootPartitionUUID}";
        preLVM = true;
        allowDiscards = true;
      }
    ];
  };

  networking.hostName = hostname;
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search 
  environment.systemPackages = with pkgs; [
    wget vim htop iw imagemagick
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 8080 80 3000 ];
  # networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver = {
    enable = true;
    layout = "us";
  };
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;


  users.extraUsers.${username} = {
     isNormalUser = true;
     uid = 1000;
     group = "wheel";
     home = "/home/${username}";
     createHome = true;
     packages = with pkgs; [ stow ];
  };
  security.sudo.configFile = "%wheel ALL=(ALL) ALL";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
