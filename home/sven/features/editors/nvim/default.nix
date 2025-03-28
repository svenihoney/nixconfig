{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    imports = [./config];
  };

  # programs.neovim = {
  #   enable = false;
  #   # package = pkgs.neovim-nightly;
  #   viAlias = true;
  #   vimAlias = true;
  #   # vimdiffAlias = true;
  #   # withNodeJs = true;
  #
  #   plugins = with pkgs.vimPlugins; [
  #     # base distro
  #     LazyVim
  #     conform-nvim
  #     nvim-lint
  #     # markdown-preview-nvim
  #     headlines-nvim
  #
  #     # theme
  #     dracula-nvim
  #
  #     # UI
  #     bufferline-nvim
  #     gitsigns-nvim
  #     edgy-nvim
  #     dashboard-nvim
  #     toggleterm-nvim
  #     trouble-nvim
  #     lualine-nvim
  #     which-key-nvim
  #     nvim-web-devicons
  #     mini-nvim
  #     noice-nvim
  #     nui-nvim
  #     nvim-notify
  #     nvim-lsp-notify
  #     neo-tree-nvim
  #     nvim-navic
  #     dressing-nvim
  #     aerial-nvim
  #     neogit
  #     diffview-nvim
  #
  #     # project management
  #     project-nvim
  #     neoconf-nvim
  #     persistence-nvim
  #     direnv-vim
  #
  #     # compilation
  #     overseer-nvim
  #
  #     # smart typing
  #     indent-blankline-nvim
  #     guess-indent-nvim
  #     vim-illuminate
  #     sleuth
  #
  #     # LSP
  #     nvim-lspconfig
  #     rust-tools-nvim
  #     crates-nvim
  #     null-ls-nvim
  #     nvim-lightbulb # lightbulb for quick actions
  #     # nvim-code-action-menu # code action menu
  #     lazydev-nvim
  #     # SchemaStore-nvim # load known formats for json and yaml
  #
  #     # cmp plugins
  #     nvim-cmp # completion plugin
  #     cmp-buffer # buffer completions
  #     cmp-path # path completions
  #     cmp_luasnip # snipper completions
  #     cmp-nvim-lsp # LSP completions
  #
  #     # snippets
  #     luasnip # snippet engine
  #     friendly-snippets # a bunch of snippets to use
  #
  #     # search functionality
  #     plenary-nvim
  #     telescope-nvim
  #     telescope-fzf-native-nvim
  #     nvim-spectre
  #     flash-nvim
  #
  #     # treesitter
  #     nvim-treesitter-context
  #     nvim-ts-autotag
  #     nvim-treesitter-textobjects
  #     nvim-treesitter.withAllGrammars
  #
  #     # comments
  #     nvim-ts-context-commentstring
  #     ts-comments-nvim
  #     todo-comments-nvim
  #
  #     # leap
  #     vim-repeat
  #     leap-nvim
  #     flit-nvim
  #
  #     # DAP
  #     nvim-dap
  #     nvim-dap-ui
  #     nvim-dap-virtual-text
  #
  #     # neotest
  #     #neotest
  #     #neotest-rust
  #
  #     # Lang: C++
  #     # cmake-tools-nvim
  #     clangd_extensions-nvim
  #     # Lang: Python
  #     nvim-dap-python
  #     #neotest-python
  #     # venv-selector-nvim
  #
  #     lazy-nvim
  #     vim-startuptime
  #   ];
  #
  #   extraPackages = with pkgs; [
  #     gcc # needed for nvim-treesitter
  #
  #     # HTML, CSS, JSON
  #     # vscode-langservers-extracted
  #
  #     # LazyVim defaults
  #     stylua
  #     shfmt
  #     statix
  #     lua-language-server
  #
  #     # Nix
  #     nil
  #     alejandra
  #
  #     # Markdown extra
  #     # nodePackages.markdownlint-cli
  #     # marksman
  #
  #     # Docker extra
  #     # nodePackages.dockerfile-language-server-nodejs
  #     # hadolint
  #     # docker-compose-language-service
  #
  #     # JSON and YAML extras
  #     # nodePackages.yaml-language-server
  #
  #     # Custom
  #     editorconfig-checker
  #     shellcheck
  #   ];
  #
  #   extraLuaConfig = ''
  #     vim.g.mapleader = " "
  #     require("lazy").setup({
  #       spec = {
  #         { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  #         -- import any extras modules here
  #         { import = "lazyvim.plugins.extras.dap.core" },
  #         { import = "lazyvim.plugins.extras.dap.nlua" },
  #         { import = "lazyvim.plugins.extras.ui.edgy" },
  #         { import = "lazyvim.plugins.extras.editor.aerial" },
  #         { import = "lazyvim.plugins.extras.editor.leap" },
  #         { import = "lazyvim.plugins.extras.editor.navic" },
  #         { import = "lazyvim.plugins.extras.lang.clangd" },
  #         { import = "lazyvim.plugins.extras.lang.python" },
  #         -- { import = "lazyvim.plugins.extras.lang.docker" },
  #         -- { import = "lazyvim.plugins.extras.lang.json" },
  #         -- { import = "lazyvim.plugins.extras.lang.markdown" },
  #         { import = "lazyvim.plugins.extras.lang.rust" },
  #         -- { import = "lazyvim.plugins.extras.lang.yaml" },
  #         { import = "lazyvim.plugins.extras.test.core" },
  #         -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
  #         { import = "lazyvim.plugins.extras.util.project" },
  #         -- import/override with your plugins
  #         { import = "plugins" },
  #       },
  #       defaults = {
  #         -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
  #         -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
  #         lazy = true,
  #         -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
  #         -- have outdated releases, which may break your Neovim install.
  #         version = false, -- always use the latest git commit
  #         -- version = "*", -- try installing the latest stable version for plugins that support semver
  #       },
  #       performance = {
  #         -- Used for NixOS
  #         reset_packpath = false,
  #         rtp = {
  #             reset = false,
  #             -- disable some rtp plugins
  #             disabled_plugins = {
  #               "gzip",
  #               -- "matchit",
  #               -- "matchparen",
  #               -- "netrwPlugin",
  #               "tarPlugin",
  #               "tohtml",
  #               "tutor",
  #               "zipPlugin",
  #             },
  #           }
  #         },
  #       dev = {
  #         path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
  #         patterns = {"folke", "nvim-telescope", "hrsh7th", "akinsho", "stevearc", "LazyVim", "catppuccin", "saadparwaiz1", "nvimdev", "rafamadriz", "lewis6991", "lukas-reineke", "nvim-lualine", "L3MON4D3", "williamboman", "echasnovski", "nvim-neo-tree", "MunifTanjim", "mfussenegger", "rcarriga", "neovim", "nvim-pack", "nvim-treesitter", "windwp", "JoosepAlviste", "nvim-tree", "nvim-lua", "RRethy", "dstein64", "Saecki", "ggandor", "iamcco", "nvim-neotest", "rouge8", "theHamsta", "SmiteshP", "jbyuki", "simrat39", "b0o", "tpope", "kosayoda", "NeogitOrg", "p00f", "sindrets", "ahmedkhalf", "stevearc", "direnv" },
  #       },
  #       install = {
  #         missing = false,
  #       },
  #     })
  #   '';
  # };

  # xdg.configFile."nvim/lua" = {
  #   recursive = true;
  #   source = ./lua;
  # };
}
