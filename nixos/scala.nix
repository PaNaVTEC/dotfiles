{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    scala ammonite sbt
  ];
}
