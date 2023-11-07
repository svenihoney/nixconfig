{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cmakeCurses
    ninja
  ];
}
