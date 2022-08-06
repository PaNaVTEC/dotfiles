{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox
    evince
    pinta
    libreoffice
    qbittorrent
    vlc
    baobab
    unstable.ledger-live-desktop
    signal-desktop
    solaar
    unstable.android-udev-rules
    # record audio
    audacity
    # sign pdfs
    xournal
    unetbootin
    synergy
    calibre
    appimage-run
    wine-staging
    lutris
    audio-recorder
  ];

  # programs.adb.enable = true;
  programs.java.enable = true;
}
