{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    jre
  ];
}
