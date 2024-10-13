{
  plugins = {
    # luasnip = {
    #   enable = true;
    #   settings = {
    #     enable_autosnippets = true;
    #     store_selection_keys = "<Tab>";
    #   };
    #   fromVscode = [
    #     {
    #       lazyLoad = true;
    #       paths = "${pkgs.vimPlugins.friendly-snippets}";
    #     }
    #   ];
    # };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = false, })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false, })";
        };
        sources = [
          {name = "nvim_lsp";}
          # {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
          {name = "cmdline";}
        ];
      };
    };
  };
}
