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

  home.file.".gdbinit".text = ''
    set auto-load safe-path /nix/store
    python
    import sys
    sys.path.insert(0, '${pkgs.gccStdenv.cc.cc.lib}/share/${pkgs.gccStdenv.cc.cc.lib.name}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    end
  '';
}
