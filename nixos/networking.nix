{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    enableIPv6 = false;
  };

  environment.systemPackages = with pkgs; [
    iw
    networkmanagerapplet
    networkmanager-l2tp
    bind
    wirelesstools
    wireguard-tools
    protonvpn-gui
    openconnect_unstable
    unstable.networkmanager-openconnect
  ];
}
