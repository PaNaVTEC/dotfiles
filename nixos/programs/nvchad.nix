{ nvchad4nix, pkgs, ... }:

{
  imports = [
    nvchad4nix.homeManagerModule
  ];

  programs.nvchad = {
    enable = true;
    hm-activation = true;
    backup = false;
  };
}