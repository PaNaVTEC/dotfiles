{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.cura
    unstable.prusa-slicer
    unstable.fstl
  ];
}
