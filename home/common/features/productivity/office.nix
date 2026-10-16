{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libreoffice-stable
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    jre
  ];
}
