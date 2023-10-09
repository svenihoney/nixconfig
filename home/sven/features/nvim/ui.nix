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


    #     'numToStr/Comment.nvim',
    #     lazy = false,
    # },
    # {
    #     'nvim-telescope/telescope.nvim', branch = '0.1.x',
    #     dependencies = { 'nvim-lua/plenary.nvim' }
    # },
    # {
    #     "folke/trouble.nvim",
    #     dependencies = { "nvim-tree/nvim-web-devicons" },
    # },
    # {
    #     "nvim-treesitter/nvim-treesitter",
    #     build = ":TSUpdate",
    # },
    # {
    #     "nvim-treesitter/nvim-treesitter-context",
    # },









    # {
    #   plugin = nvim-bqf;
    #   type = "lua";
    #   config = /* lua * */ ''
    #     require('bqf').setup{}
    #   '';
    # }
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
    # {
    #   plugin = bufferline-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('bufferline').setup{}
    #   '';
    # }
    # {
    #   plugin = scope-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('scope').setup{}
    #   '';
    # }
    # {
    #   plugin = which-key-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('which-key').setup{}
    #   '';
    # }
    # {
    #   plugin = range-highlight-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('range-highlight').setup{}
    #   '';
    # }
    # {
    #   plugin = indent-blankline-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('indent_blankline').setup{char_highlight_list={'IndentBlankLine'}}
    #   '';
    # }
    # {
    #   plugin = nvim-web-devicons;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('nvim-web-devicons').setup{}
    #   '';
    # }
    # {
    #   plugin = gitsigns-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('gitsigns').setup{
    #       signs = {
    #         add = { text = '+' },
    #         change = { text = '~' },
    #         delete = { text = '_' },
    #         topdelete = { text = '‾' },
    #         changedelete = { text = '~' },
    #       },
    #     }
    #   '';
    # }
    # {
    #   plugin = nvim-colorizer-lua;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('colorizer').setup{}
    #   '';
    # }
    # {
    #   plugin = fidget-nvim;
    #   type = "lua";
    #   config = /* lua */ ''
    #     require('fidget').setup{
    #       text = {
    #         spinner = "dots",
    #       },
    #     }
    #   '';
    # }
  ];
}
