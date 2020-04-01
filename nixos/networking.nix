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
    bind
    wirelesstools
    wireguard
    linuxHeaders
  ];
}
