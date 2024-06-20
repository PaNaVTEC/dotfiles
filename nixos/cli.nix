{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.eza
    unzip
    unrar
    jq
    neofetch
    pciutils
    speedtest-cli
    ranger
    w3m
    ffmpegthumbnailer
    atool
    tasksh
    xsel
    lm_sensors
    silver-searcher
    ripgrep
    htop
    powerline-go
    starship
    nix-prefetch-git
    bat
    youtube-dl
    exfat
    tldr
    killall
    wget
    vim
    imagemagick
    gnumake
    binutils
    sshpass
    gitAndTools.gh
    bc
    gparted
    httpie
    grpcurl
    loc

    #exfat
    exfat
    ntfs3g
    # fat32
    dosfstools
    mtools
  ];

  programs = {
    bash.enableCompletion = true;
    tmux.enable = true;
  };
}
