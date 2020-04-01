{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keepass
    keepass-keepasshttp
    keepassxc
    gksu
  ];

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
}
