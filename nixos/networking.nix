{ config, pkgs, ... }:

{

  networking = {
    networkmanager.enable = true;
    nameservers = ["103.86.96.100" "103.86.99.100"];
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
