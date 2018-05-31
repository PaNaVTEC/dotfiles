{ config, pkgs, ... }:

let
  userModule = (import ./user.nix);
  username = userModule.name;
  rootPartitionUUID = userModule.rootPartitionUUID;
  n = pkgs.callPackage ./pkgs/npackagemanager { };
in
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./networking.nix
      ./i3.nix
      ./urxvt.nix
      ./fonts.nix
      ./apps.nix
      ./emacs.nix
      ./scala.nix
      ./java.nix
      ./haskell.nix
      ./git.nix
      ./virtualization.nix
      ./containerization.nix
      ./security.nix
      ./web-browsers.nix
      ./golang.nix
      ./cli.nix
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
    wget vim htop imagemagick n gcc gnumake binutils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
     group = "users";
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk"
     ];
     home = "/home/${username}";
     createHome = true;
     packages = with pkgs; [ stow ];
  };
  security.sudo.configFile = "%wheel ALL=(ALL) ALL";

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
