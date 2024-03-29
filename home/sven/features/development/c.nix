{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnumake
    cmakeCurses
    cmake-language-server
    ninja
    gcc
    gdb
    # LSP
    libclang
    cmake-language-server
  ];

  home.sessionVariables.CMAKE_GENERATOR = "Ninja";
}
