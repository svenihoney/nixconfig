{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    jre
  ];
}
