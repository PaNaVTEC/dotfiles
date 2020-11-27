{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs27
    sqlite # Required by helm-dash
  ];
}
