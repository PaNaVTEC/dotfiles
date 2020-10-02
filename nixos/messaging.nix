{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zoom-us
    slack
    discord
  ];

}
