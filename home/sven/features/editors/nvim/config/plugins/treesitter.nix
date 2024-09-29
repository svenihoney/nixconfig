{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    # grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    #     c
    #     lua
    # ];
  };
}
