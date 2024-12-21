{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.adb.enable = true;
  programs.java = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    gibo
    gitAndTools.hub
    gitAndTools.diff-so-fancy

    gnupg
    pinentry

    docker-compose
    linuxHeaders

    direnv
    alacritty
    # lunarvim

    # Ide/editors
    emacs
    sqlite # Required by helm-dash
    devbox
    unstable.code-cursor

    # unstable.vscode-with-extensions
    (unstable.vscode-with-extensions.override {
      vscodeExtensions = with unstable.vscode-extensions; [
        ms-vsliveshare.vsliveshare
        ms-vscode.cpptools
        vscodevim.vim
      ] ++ unstable.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode-extensions.nix).extensions;
    })
  ];

  # Solves problems with file watchers, too many open files
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "65536";
    }
  ];
}
