{ config, pkgs, ... }:

{
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
}
