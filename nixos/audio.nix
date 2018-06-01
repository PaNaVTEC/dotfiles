{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    ponymix
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
