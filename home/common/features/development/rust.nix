{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.rust {
    home.packages = with pkgs; [
      # rustc
      rust-analyzer
    ];

    programs.nixvim.plugins.lsp.servers = {
      rust_analyzer = {
        enable = config.svenihoney.devel.rust;
        installRustc = false;
        installCargo = false;
      };
    };
  };
}
