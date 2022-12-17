{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.cura
    unstable.fstl
  ];
}
