{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virtualbox linuxHeaders vagrant
  ];
}
