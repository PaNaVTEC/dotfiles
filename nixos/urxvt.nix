{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt_unicode
  ];

  systemd.user.services.urxvtd = {
    enable = true;
  };
}
