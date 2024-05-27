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
      "cgdjpilhipecahhcilnafpblkieebhea" # send to kindle
      "plfbhieilacgkdnphcdehdnhjenmnima" # epoch converter
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
