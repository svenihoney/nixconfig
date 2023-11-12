{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnumake
    cmakeCurses
    ninja
    gcc
    gdb
  ];
}
