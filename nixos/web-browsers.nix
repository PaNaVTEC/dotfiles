{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
    chromium
    firefox
    unstable.brave
  ];
}
