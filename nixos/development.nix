{ pkgs, channels, config, ... }:

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
    virtualbox
    linuxHeaders

    direnv
    alacritty
    lunarvim

    # Ide/editors
    emacs
    sqlite # Required by helm-dash
    devbox

    # unstable.vscode-with-extensions
    (unstable.vscode-with-extensions.override {
      vscodeExtensions = with unstable.vscode-extensions; [
        ms-vsliveshare.vsliveshare
        ms-vscode.cpptools
        vscodevim.vim
      ] ++ unstable.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode-extensions.nix).extensions;
    })
  ];
  
  # oLlama
  networking.firewall.allowedTCPPorts = [11434];
  services.ollama = {
    enable = true;
    environmentVariables = {
      # "OLLAMA_ORIGINS" = "https://hollama.fernando.is";
      "OLLAMA_ORIGINS" = "*";
    };
  }; 

  imports = [ "${channels.nixos-unstable}/nixos/modules/services/misc/open-webui.nix" ];
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    host = "0.0.0.0";
    port = 3000;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      TRANSFORMERS_CACHE = "${config.services.open-webui.stateDir}/cache";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      # Disable authentication
      WEBUI_AUTH = "False";
    };
    openFirewall = true;
  };

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
