{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exa
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
    ag
    ripgrep
    powerline-go
    nix-prefetch-git
    bat
    youtube-dl
    exfat
    tldr
    glances
    killall
    wget
    vim
    imagemagick
    gnumake
    binutils
    sshpass
    gitAndTools.gh

    #exfat
    exfat
    exfat-utils
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
