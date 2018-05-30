{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gibo
    gitAndTools.hub
    gitAndTools.tig
    gitAndTools.diff-so-fancy
  ];
}
