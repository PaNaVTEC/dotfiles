{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt-unicode-unwrapped-emoji
  ];

  systemd.user.services.urxvtd = {
    enable = true;
  };
}
