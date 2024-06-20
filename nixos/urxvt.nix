{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt-unicode-unwrapped-emoji
    alacritty
  ];

  systemd.user.services.urxvtd = {
    enable = true;
  };
}
