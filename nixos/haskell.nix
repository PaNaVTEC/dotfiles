{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.stack
    haskellPackages.hindent
    haskellPackages.stylish-haskell
    haskellPackages.cabal-install
    haskellPackages.hlint
    haskellPackages.hoogle
  ];
}
