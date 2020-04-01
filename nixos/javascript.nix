{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    nodePackages.tern
    sass
    nodePackages.grunt-cli
  ];
}
