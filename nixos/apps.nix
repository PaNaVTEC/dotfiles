{ config, pkgs, ... }:

{
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    unstable.weston
    unstable.wl-clipboard
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
    config.nur.repos.k3a.ib-tws
    slack
  ];
}
