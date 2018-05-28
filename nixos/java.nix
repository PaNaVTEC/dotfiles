{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openjdk openjdk10 maven gradle jetbrains.idea-community
  ];
}
