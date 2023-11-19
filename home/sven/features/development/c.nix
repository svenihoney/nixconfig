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

  home.sessionVariables.CMAKE_GENERATOR = "Ninja";
}
