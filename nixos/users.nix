{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [(import "${home-manager}/nixos")];

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
    };
  };
}
