{ config, pkgs, ... }:

let
  vscode-vim-patched = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "vim";
        publisher = "vscodevim";
        version = "1.24.1";
        sha256 = "00gq6mqqwqipc6d7di2x9mmi1lya11vhkkww9563avchavczb9sv";
      };
      postPatch = ''
        sed -i 's/\[\["w","rite"\],D.WriteCommand.argParser\]/\[\["w","rite"\],D.WriteCommand.argParser\],\[\["W","rite"\],D.WriteCommand.argParser\],\[\["Wa","ll"\],j.WallCommand.argParser\],\[\["WA","ll"\],j.WallCommand.argParser\]/g' ./out/extension.js
      '';
    };

in {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    extraOptions = "--config-file=/etc/docker-daemon.json";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # programs.adb.enable = true;
  programs.java = {
    enable = true;
    # package = pkgs.openjdk16-bootstrap;
  };

  # environment.variables = {
  #   JAVA_HOME = "/run/current-system/sw";
  # };

  environment.systemPackages = with pkgs; [
    git
    gibo
    gitAndTools.hub
    gitAndTools.diff-so-fancy
    mob

    gnupg
    pinentry
    pinentry-gnome

    docker-compose
    virtualbox
    linuxHeaders

    direnv

    # Ide/editors
    unstable.jetbrains.idea-community
    emacs
    sqlite # Required by helm-dash

    # unstable.vscode-fhs
    (vscode-with-extensions.override {
      vscodeExtensions = [ vscode-extensions.ms-vsliveshare.vsliveshare vscode-vim-patched ] ++ map
        (extension: vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
           inherit (extension) name publisher version sha256;
          };
        })
        (import ./vscode-extensions.nix).extensions;
    })
    rnix-lsp # nix language server

    # openjdk16-bootstrap
    # amazon-corretto17
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

  # Add yourself as a trusted user so you can use the Nix binary caches
  # nix.settings.trusted-users = [ "root" "panavtec" "@wheel" "@sudo" ];

  # auth keyring for VS Code
  # services.gnome.gnome-keyring.enable = true;
  # programs.seahorse.enable = true;
}
