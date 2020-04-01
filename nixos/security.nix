{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gksu
  ];

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
}
