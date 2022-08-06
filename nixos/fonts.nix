{ config, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      twemoji-color-font
      symbola
      nerdfonts
      font-awesome
      iosevka-bin
      cantarell-fonts
    ];
  };
}
