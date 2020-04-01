{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    ponymix
    clementine
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
