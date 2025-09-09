{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.python {
    home.packages = with pkgs; [
      # python3
      (python3.withPackages (ps: with ps; [debugpy]))
      # python3Packages.debugpy
      # pyright
      basedpyright
    ];

    programs.nixvim.plugins.lsp.servers = {
      basedpyright.enable = config.svenihoney.devel.python;
      ruff.enable = config.svenihoney.devel.python;
    };
  };
}
