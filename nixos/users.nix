{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  xdgBrowser = ["chromium-browser.desktop"];
  xdgImageViewer = ["org.gnome.eog.desktop"];
  xdgVlc = ["vlc.desktop"];
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.panavtec = {
     isNormalUser = true;
     extraGroups = [
       "wheel" "networkmanager" "systemd-journal" "audio" "video" "disk" "docker" "plugdev" "adbusers" "adb"
     ];
  };

  home-manager.users.panavtec = {
    xdg.configFile."Code/User/keybindings.json".source = /home/panavtec/dotfiles/config/vscode/.config/Code/User/keybindings.json;
    xdg.configFile."Code/User/settings.json".source = /home/panavtec/dotfiles/config/vscode/.config/Code/User/settings.json;
    xdg.configFile."starship.toml".source = /home/panavtec/dotfiles/config/starship/.config/starship.toml;
    xdg.configFile."alacritty.yml".source = /home/panavtec/dotfiles/config/alacritty/alacritty.yml;

    ## Debugging tools:
    ## XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype foo.pdf
    ## XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default application/pdf
    ## fd evince.desktop /
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "video/mp4" = xdgVlc;
        "image/bmp" = xdgImageViewer;
        "image/gif" = xdgImageViewer;
        "image/jpg" = xdgImageViewer;
        "image/pjpeg" = xdgImageViewer;
        "image/png" = xdgImageViewer;
        "image/tiff" = xdgImageViewer;
        "image/webp" = xdgImageViewer;
        "image/x-bmp" = xdgImageViewer;
        "image/x-gray" = xdgImageViewer;
        "image/x-icb" = xdgImageViewer;
        "image/x-ico" = xdgImageViewer;
        "image/x-png" = xdgImageViewer;
        "image/x-portable-anymap" = xdgImageViewer;
        "image/x-portable-bitmap" = xdgImageViewer;
        "image/x-portable-graymap" = xdgImageViewer;
        "image/x-portable-pixmap" = xdgImageViewer;
        "image/x-xbitmap" = xdgImageViewer;
        "image/x-xpixmap" = xdgImageViewer;
        "image/x-pcx" = xdgImageViewer;
        "image/svg+xml" = xdgImageViewer;
        "image/svg+xml-compressed" = xdgImageViewer;
        "image/vnd.wap.wbmp" = xdgImageViewer;
        "image/x-icns" = xdgImageViewer;
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "text/html" = xdgBrowser;
        "application/x-extension-htm" = xdgBrowser;
        "application/x-extension-html" = xdgBrowser;
        "application/x-extension-shtml" = xdgBrowser;
        "application/xhtml+xml" = xdgBrowser;
        "application/x-extension-xhtml" = xdgBrowser;
        "application/x-extension-xht" = xdgBrowser;
        "x-scheme-handler/http" = xdgBrowser;
        "x-scheme-handler/https" = xdgBrowser;
        "x-scheme-handler/ftp" = xdgBrowser;
        "x-scheme-handler/chrome" = xdgBrowser;
        "x-scheme-handler/about" = xdgBrowser;
        "x-scheme-handler/unknown" = xdgBrowser;
        "x-scheme-handler/mailto" = xdgBrowser;
        "x-scheme-handler/webcal" = xdgBrowser;
        "default-web-browser" = xdgBrowser;
        "video/mp4" = xdgVlc;
        "image/jpeg" = xdgImageViewer;
        "image/bmp" = xdgImageViewer;
        "image/gif" = xdgImageViewer;
        "image/jpg" = xdgImageViewer;
        "image/pjpeg" = xdgImageViewer;
        "image/png" = xdgImageViewer;
        "image/tiff" = xdgImageViewer;
        "image/webp" = xdgImageViewer;
        "image/x-bmp" = xdgImageViewer;
        "image/x-gray" = xdgImageViewer;
        "image/x-icb" = xdgImageViewer;
        "image/x-ico" = xdgImageViewer;
        "image/x-png" = xdgImageViewer;
        "image/x-portable-anymap" = xdgImageViewer;
        "image/x-portable-bitmap" = xdgImageViewer;
        "image/x-portable-graymap" = xdgImageViewer;
        "image/x-portable-pixmap" = xdgImageViewer;
        "image/x-xbitmap" = xdgImageViewer;
        "image/x-xpixmap" = xdgImageViewer;
        "image/x-pcx" = xdgImageViewer;
        "image/svg+xml"= xdgImageViewer;
        "image/svg+xml-compressed" = xdgImageViewer;
        "image/vnd.wap.wbmp" = xdgImageViewer;
        "image/x-icns" = xdgImageViewer;
      };
    };

    home = {
      stateVersion = "22.11";

      file.".bashrc".source = /home/panavtec/dotfiles/config/bash/.bashrc;
      file.".bash_profile".source = /home/panavtec/dotfiles/config/bash/.bash_profile;
      file.".dircolors".source = /home/panavtec/dotfiles/config/dircolors/.dircolors;
      file.".ghci".source = /home/panavtec/dotfiles/config/ghci/.ghci;
      file.".gitconfig".source = /home/panavtec/dotfiles/config/git/.gitconfig;
      file.".gitconfig-siriusxm".source = /home/panavtec/dotfiles/config/git/.gitconfig-siriusxm;
      file.".inputrc".source = /home/panavtec/dotfiles/config/inputrc/.inputrc;
      file.".tmux.conf".source = /home/panavtec/dotfiles/config/tmux/.tmux.conf;

      file.".urxvt/ext/font-size".source = /home/panavtec/dotfiles/config/urxvt/.urxvt/ext/font-size;
      file.".urxvt/ext/keyboard-select".source = /home/panavtec/dotfiles/config/urxvt/.urxvt/ext/keyboard-select;
      file.".urxvt/ext/vtwheel".source = /home/panavtec/dotfiles/config/urxvt/.urxvt/ext/vtwheel;

      file.".xurxvt".source = /home/panavtec/dotfiles/config/xresources/.xurxvt;
      file.".xcolors".source = /home/panavtec/dotfiles/config/xresources/.xcolors;
      file.".Xresources".source = /home/panavtec/dotfiles/config/xresources/.Xresources;
      file.".Xdefaults".source = /home/panavtec/dotfiles/config/xresources/.Xdefaults;
      file.".emacs.d/init.el".source = /home/panavtec/dotfiles/config/emacs/.emacs.d/init.el;
      file.".gitignore.global".source = /home/panavtec/dotfiles/config/git/.gitignore.global;
      file.".git-completion.bash".source = /home/panavtec/dotfiles/config/git/.git-completion.bash;
    };

    dconf.settings = {
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };

      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
        document-font-name = "Iosevka 11";
        enable-animations = true;
        enable-hot-corners = false;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-name = "Iosevka 11";
        monospace-font-name= "Iosevka 10";
        toolkit-accessibility = false;
      };

      "org/gnome/desktop/input-sources" =
        let
          mkTuple = (import "${home-manager}/modules/lib/gvariant.nix" {lib = lib;}).mkTuple;
        in {
          sources = [ (mkTuple [ "xkb" "us+altgr-intl" ]) ];
          xkb-options = [ "terminate:ctrl_alt_bksp" ];
          color-scheme = "prefer-dark";
        };

      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Shift><Super>q"];
        move-to-workspace-1 = ["<Shift><Super>exclam"];
        move-to-workspace-2 = ["<Shift><Super>at"];
        move-to-workspace-3 = ["<Shift><Super>numbersign"];
        move-to-workspace-4 = ["<Shift><Super>dollar"];
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        toggle-maximized = ["<Super>f"];
      };

      # Needed so switch-to-workspace works
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [""];
        switch-to-application-2 = [""];
        switch-to-application-3 = [""];
        switch-to-application-4 = [""];
        switch-to-application-5 = [""];
        switch-to-application-6 = [""];
        switch-to-application-7 = [""];
        switch-to-application-8 = [""];
        switch-to-application-9 = [""];
      };

      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Iosevka Bold 11";
        audible-bell = false;
      };

      "org/gnome/nautilus/preferences" = {
        search-filter-time-type = "last_modified";
        default-folder-viewer = "list-view";
        search-view = "list-view";
        sort-directories-first = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Shift><Super>Return";
        command = "alacritty";
        name = "Launch terminal";
      };

      "org/gnome/shell" = {
        enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com"  "gnome-shell-duckduckgo-search-provider@keithcirkel.co.uk"  "just-perfection-desktop@just-perfection"  "Vitals@CoreCoding.com"  "sound-output-device-chooser@kgshank.net"  "extensions-sync@elhan.io"  "unite@hardpixel.eu"  "workspaces-bar@fthx"  "forge@jmmaranan.com"  "draw-on-your-screen2@zhrexl.github.com"];
      };

      "org/gnome/shell/extensions/forge" = {
        tiling-mode-enabled = true;
        window-gap-hidden-on-single = true;
      };

      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = true;
        activities-button = false;
        animation = 3;
        app-menu = true;
        panel = true;
        panel-size = 0;
      };

      "org/gnome/shell/extensions/unite" = {
        app-menu-ellipsize-mode = "end";
        extend-left-box = false;
        greyscale-tray-icons = false;
        hide-activities-button = "always";
        hide-app-menu-icon = false;
        hide-dropdown-arrows = true;
        hide-window-titlebars = "always";
        notifications-position = "center";
        reduce-panel-spacing = true;
        show-window-buttons = "never";
        show-window-title = "always";
        window-buttons-placement = "last";
        window-buttons-theme = "sweet";
      };

      "org/gnome/shell/extensions/vitals" = {
        fixed-widths = true;
        hide-icons = false;
        hot-sensors = ["_memory_usage_" "_system_load_1m_"];
        show-fan = true;
        show-memory = true;
        show-temperature = true;
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
      };

      "org/gtk/gtk/settings/file-chooser" = {
        sort-directories-first = true;
      };
    };
  };
}
