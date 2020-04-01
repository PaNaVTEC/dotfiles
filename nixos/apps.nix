{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox
    evince
    pinta
    beancount
    fava
    libreoffice
    transmission_gtk
    vlc
    baobab
  ];
}
