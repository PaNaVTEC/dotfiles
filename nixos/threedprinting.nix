{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.cura
    unstable.fstl
  ];
}
