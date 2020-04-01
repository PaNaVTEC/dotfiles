{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox
    evince
    pinta
    libreoffice
    transmission_gtk
    vlc
    baobab
  ];
}
