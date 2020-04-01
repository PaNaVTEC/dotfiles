{ config, pkgs, ... }:

{
  users.extraUsers.carlos = {
     isNormalUser = true;
     uid = 1000;
     group = "users";
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk" "docker"
     ];
     home = "/home/carlos";
     createHome = true;
     packages = with pkgs; [ stow ];
  };

}
