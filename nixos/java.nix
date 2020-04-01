{ config, pkgs, ... }:

{

  programs.java = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
  ];
}
