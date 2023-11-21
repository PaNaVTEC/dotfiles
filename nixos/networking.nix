{ config, pkgs, ... }:

{
  services.globalprotect = {
    enable = true;
    # if you need a Host Integrity Protection report
    csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

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
    globalprotect-openconnect
  ];
}
