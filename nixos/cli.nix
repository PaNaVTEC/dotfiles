{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exa
    unzip
    unrar
    jq
    neofetch
    speedtest-cli
    ranger
    w3m
    ffmpegthumbnailer
    atool
    tasksh
    xsel
    lm_sensors
    ag
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
    exfat
    exfat-utils
    ntfs3g
  ];

  programs = {
    bash.enableCompletion = true;
    tmux.enable = true;
  };
}
