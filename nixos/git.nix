{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gibo
    gitAndTools.hub
    gitAndTools.diff-so-fancy
  ];
}
