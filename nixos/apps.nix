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
    alacritty
    # record audio
    audacity
    qbittorrent
    cinnamon.warpinator
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
  # warpinator
  networking.firewall = {
    allowedTCPPorts = [ 42000 42001 ];
    allowedUDPPorts = [ 5353 ];
  };
}
