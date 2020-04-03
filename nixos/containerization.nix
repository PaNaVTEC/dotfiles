{ config, pkgs, ... }:

{

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker_compose
  ];
}
