{ config, pkgs, ... }:

{
  users.users.panavtec = {
     isNormalUser = true;
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk" "docker" "plugdev"
     ];
     packages = with pkgs; [ stow ];
  };

}
