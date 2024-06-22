{ ... }:

{
  users.users.panavtec = {
     isNormalUser = true;
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk" "docker" "plugdev" "adbusers" "adb"
     ];
  };

  xdg.mime.defaultApplications = {
    "text/html" = "chromium.desktop";
    "x-scheme-handler/http" = "chromium.desktop";
    "x-scheme-handler/https" = "chromium.desktop";
    "x-scheme-handler/about" = "chromium.desktop";
    "x-scheme-handler/unknown" = "chromium.desktop";
  };

  programs.dconf.enable = true;
}
