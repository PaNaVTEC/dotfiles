{ config, pkgs, ... }:

{
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

    gnupg
    pinentry
    pinentry-gnome

    docker-compose
    virtualbox
    linuxHeaders

    direnv

    # Ide/editors
    unstable.jetbrains.idea-community
    unstable.vscode-fhs

    # openjdk16-bootstrap
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
