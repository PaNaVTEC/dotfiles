{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    stack
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.hindent
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    haskellPackages.hoogle
  ];
}
