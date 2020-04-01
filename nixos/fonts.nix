{ config, pkgs, ... }:

let
  terminus-td1 = pkgs.stdenv.lib.overrideDerivation pkgs.terminus_font (oldAttrs : {
    postPatch = ''
      patch < alt/td1.diff
    '' + oldAttrs.postPatch;
  });
in
{
  fonts = {
    fonts = with pkgs; [
      terminus-td1
      twemoji-color-font
      google-fonts
      noto-fonts-emoji
      symbola
      nerdfonts
      font-awesome-ttf
    ];
  };
}
