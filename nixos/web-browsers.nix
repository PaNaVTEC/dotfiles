{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
    chromium
    firefox
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly
      "neebplgakaahbhdphmkckjjcegoiijjo" # keepa
#      "dcpihecpambacapedldabdbpakmachpb;https://github.com/iamadamdev/bypass-paywalls-chrome/archive/master.zip"
    ];
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = ["es" "en-US"];
    };
  };
}
