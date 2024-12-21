{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.fstl
    unstable.orca-slicer
    unstable.bambu-studio
  ];
}
