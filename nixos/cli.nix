{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    shellcheck
    autojump
    exa
    dropbox-cli
    unzip
    unrar
    jq
    neofetch
    speedtest-cli
  ];

  programs.bash.enableCompletion = true;
}
