{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import "${builtins.fetchTarball https://github.com/vlaci/openconnect-sso/archive/master.tar.gz}/overlay.nix")
  ];

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
    #openconnect_unstable
    openconnect-sso
    unstable.networkmanager-openconnect
  ];
}
