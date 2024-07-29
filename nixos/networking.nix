{ pkgs, ... }:

{
  services.globalprotect = {
    enable = true;
    csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

  services.clamav = {
    scanner.enable = true;
    updater = {
      enable = true;
      frequency = 1;
      interval = "weekly";
    };
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
    networkmanager-openconnect
  ];
}
