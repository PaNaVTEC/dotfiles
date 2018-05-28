{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker docker_compose
  ];
}
