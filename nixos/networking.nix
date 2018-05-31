{ config, pkgs, ... }:

let
  userModule = (import ./user.nix);
  hostname = userModule.hostname;
in
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 8080 80 3000 ];
  # networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    iw networkmanagerapplet openresolv
  ];
}
