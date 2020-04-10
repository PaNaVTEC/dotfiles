{ config, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      twemoji-color-font
      google-fonts
      noto-fonts-emoji
      symbola
      nerdfonts
      font-awesome-ttf
      iosevka-bin
    ];
  };
}
