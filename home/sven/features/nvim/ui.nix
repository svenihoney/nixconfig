{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # UI
    {
      plugin = vim-fugitive;
      type = "viml";
      config = /* vim */ ''
        nmap <space>gg :Git<CR>
      '';
    }
    {
      plugin = comment-nvim;
      type = "lua";
      config = /* lua * */ ''
        require("Comment").setup()
      '';
    }
    {
      plugin = telescope-nvim;
      type = "lua";
      config = /* lua * */ ''
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
        vim.keymap.set('n', '<leader><leader>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      '';
    }
    {
      plugin = trouble-nvim;
      type = "lua";
      config = /* lua * */ ''
        vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
        vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
        vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
        vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
        vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
        vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
      '';
    }
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = /* lua */ ''
        require'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all"
          -- ensure_installed = { "vimdoc", "javascript", "c", "lua", "rust", "python" },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          -- sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          -- auto_install = true,

          highlight = {
              -- `false` will disable the whole extension
              enable = true,

              -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
              -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
              -- Using this option may slow down your editor, and you may see some duplicate highlights.
              -- Instead of true it can also be a list of languages
              additional_vim_regex_highlighting = false,
          },
        }
      '';
    }
    {
      plugin = alpha-nvim;
      type = "lua";
      config = /* lua */ ''
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
              "                                                     ",
              "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
              "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
              "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
              "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
              "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
              "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
              "                                                     ",
        }
        dashboard.section.header.opts.hl = "Title"

        dashboard.section.buttons.val = {
            dashboard.button( "n", "󰈔 New file" , ":enew<CR>"),
            dashboard.button( "e", " Explore", ":Explore<CR>"),
            dashboard.button( "g", " Git summary", ":Git | :only<CR>"),
            dashboard.button( "c", "  Nix config flake" , ":cd ~/Documents/NixConfig | :e flake.nix<CR>"),
            dashboard.button( "q", "󰅙  Quit nvim", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
        vim.keymap.set("n", "<space>a", ":Alpha<CR>", { desc = "Open alpha dashboard" })
      '';
    }
  ];
}
