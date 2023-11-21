{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    dropbox
    evince
    pinta
    libreoffice
    filezilla
    via
    vlc
    baobab
    unstable.ledger-live-desktop
    signal-desktop
    unstable.android-udev-rules
    # record audio
    audacity
    qbittorrent
    # sign pdfs
    xournal
    synergy
    calibre
    appimage-run
    audio-recorder
    unstable.portfolio
    unstable.bitwarden
    pkgs.nur.repos.k3a.ib-tws
  ];
}
