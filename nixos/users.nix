{ config, pkgs, ... }:

{
  users.users.panavtec = {
     isNormalUser = true;
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk" "docker" "plugdev" "adbusers" "adb"
     ];
     packages = with pkgs; [ stow ];
  };

}
