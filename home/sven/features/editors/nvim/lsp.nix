{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # LSP
    {
      plugin = lsp-zero-nvim;
      type = "lua";
      config = # vim
        ''
          local lsp_zero = require('lsp-zero')

          lsp_zero.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          end)
        '';
    }
    {
      plugin = mason-nvim;
      type = "lua";
      config = # lua *
        ''
          require('mason').setup({})
        '';
    }
    {
      plugin = mason-lspconfig-nvim;
      type = "lua";
      config = # lua *
        ''
          require('mason-lspconfig').setup({
            handlers = {
              lsp_zero.default_setup,
            }
          })
        '';
    }
    {
      plugin = nvim-lspconfig;
      type = "lua";
    }
    {
      plugin = cmp-nvim-lsp;
      type = "lua";
    }
    {
      plugin = nvim-cmp;
      type = "lua";
      config = # lua *
        ''
          local cmp = require('cmp')
          local cmp_select = {behavior = cmp.SelectBehavior.Select}

          cmp.setup({
            sources = {
              {name = 'path'},
              {name = 'nvim_lsp'},
              {name = 'nvim_lua'},
            },
            -- formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
              ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
              ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
              ['<C-y>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
            }),
          })
        '';
    }
    {
      plugin = luasnip;
      type = "lua";
    }

  ];
}
