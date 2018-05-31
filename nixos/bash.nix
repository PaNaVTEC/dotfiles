{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    shellcheck
  ];

  programs.bash.enableCompletion = true;
}
