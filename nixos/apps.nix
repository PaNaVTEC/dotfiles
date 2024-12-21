{ config, pkgs, ... }:

{
  virtualisation = {
    lxd.enable = true;
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
        enableKvm = true;
        enableHardening = false;
        addNetworkInterface = false;
      };
      guest = {
        enable = true;
        clipboard = true;
        dragAndDrop = true;
      };
    };
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
    # sign pdfs
    xournal
    synergy
    calibre
    appimage-run
    audio-recorder
    unstable.portfolio
    unstable.bitwarden
    # config.nur.repos.k3a.ib-tws
    slack
    unstable.postman
  ];
  # warpinator
  networking.firewall = {
    allowedTCPPorts = [ 42000 42001 ];
    allowedUDPPorts = [ 5353 ];
  };
}
