{ config, pkgs, ... }:

let
  yarn1 = pkgs.stdenv.lib.overrideDerivation pkgs.yarn (oldAttrs : {
    postInstall = oldAttrs.postInstall +
    "
      yarn config set -- --emoji true;
      yarn global add n;
      n latest;
      yarn global add tern standard create-react-app js-beautify';
      yarn global add typescript tslint eslint-plugin-typescript typescript-eslint-parser;
    ";
  });
in
{
  environment.systemPackages = with pkgs; [
    nodejs yarn1
  ];
}
