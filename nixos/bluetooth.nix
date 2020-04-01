{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
  ];

  hardware.pulseaudio = {
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };

  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

}
