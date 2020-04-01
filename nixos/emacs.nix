{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    custom-overlays.emacs27
    sqlite # Required by helm-dash
  ];
}
