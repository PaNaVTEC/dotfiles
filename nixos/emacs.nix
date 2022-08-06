{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs
    sqlite # Required by helm-dash
  ];
}
