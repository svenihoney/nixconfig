{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.c {
    home.packages = with pkgs;
      [
        # LSP
        cmake-language-server
        neocmakelsp
        clang-tools

        gnumake
        cmakeCurses
        ninja
        gcc
        gdb
      ]
      ++ (lib.optionals config.svenihoney.desktop.enable [
        # zeal
        # qtcreator
      ]);

    home.sessionVariables = {
      CMAKE_GENERATOR = "Ninja";
      CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
      # CMAKE_BUILD_TYPE = "Debug";
    };

    home.file.".gdbinit".text = ''
      set auto-load safe-path /nix/store
      python
      import sys
      from os import listdir
      share_gcc = listdir('${pkgs.gccStdenv.cc.cc.lib}/share')
      sys.path.insert(0, '${pkgs.gccStdenv.cc.cc.lib}/share/' + share_gcc[0] + '/python')
      from libstdcxx.v6.printers import register_libstdcxx_printers
      register_libstdcxx_printers (None)
      end
    '';

    programs.nixvim.plugins.lsp.servers = {
      clangd.enable = true;
      # extraOptions = "--log=verbose";
      # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd" "--log=verbose"];
      # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd"];
    };
  };
}
