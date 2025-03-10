{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.lsp.enable {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };

        # grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        #     c
        #     lua
        #     just
        #     nix
        # ];
      };
      treesitter-textobjects.enable = true;
    };
  };
}
