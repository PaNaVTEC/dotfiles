{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git gitAndTools.hub gitAndTools.tig gibo 
  ];
}
