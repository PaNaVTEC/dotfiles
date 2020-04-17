{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox
    evince
    pinta
    libreoffice
    qbittorrent
    vlc
    baobab
  ];
}
