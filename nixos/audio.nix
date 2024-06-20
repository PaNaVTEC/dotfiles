{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio-ctl
    ponymix
    clementine
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
