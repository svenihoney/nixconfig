{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./lsp.nix
    # ./syntaxes.nix
    # ./ui.nix
  ];
  # home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # UI
      {
        plugin = lazy-nvim;
        type = "lua";
      }
      {
        plugin = LazyVim;
        type = "lua";
        config =
          /*
          lua *
          */
          ''
            require("lazy").setup({
              spec = {
                -- add LazyVim and import its plugins
                { "LazyVim/LazyVim", import = "lazyvim.plugins" },
                -- import any extras modules here
                -- { import = "lazyvim.plugins.extras.lang.typescript" },
                -- { import = "lazyvim.plugins.extras.lang.json" },
                -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
                -- import/override with your plugins
                { import = "plugins" },
              },
              defaults = {
                -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
                -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
                lazy = false,
                -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
                -- have outdated releases, which may break your Neovim install.
                version = false, -- always use the latest git commit
                -- version = "*", -- try installing the latest stable version for plugins that support semver
              },
              install = { colorscheme = { "tokyonight", "habamax" } },
              checker = { enabled = true }, -- automatically check for plugin updates
              performance = {
                rtp = {
                  -- disable some rtp plugins
                  disabled_plugins = {
                    "gzip",
                    -- "matchit",
                    -- "matchparen",
                    -- "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                  },
                },
              },
            })
          '';
      }
    ];

    extraLuaConfig = ''
    '';
    #   vim.opt.number = true                                  -- show line numbers
    #   vim.opt.ruler = true
    #   vim.opt.ttyfast = true                                 -- terminal acceleration

    #   vim.opt.tabstop = 4                               -- 4 whitespaces for tabs visual presentation
    #   vim.opt.shiftwidth = 4                            -- shift lines by 4 spaces
    #   vim.opt.smarttab = true                                -- set tabs for a shifttabs logic
    #   vim.opt.expandtab = true                               -- expand tabs into spaces
    #   vim.opt.autoindent = true                              -- indent when moving to the next line while writing code

    #   -- set cursorline                              -- shows line under the cursor's line
    #   vim.opt.showmatch = true                               -- shows matching part of bracket pairs (), [], {}

    #   -- vim.opt.enc = utf-8                              -- utf-8 by default

    #   vim.opt.backup = false                              -- no backup files
    #   vim.opt.writebackup = false                           -- only in case you don't want a backup file while editing
    #   vim.opt.swapfile = false                                -- no swap files

    #   vim.opt.backspace = indent,eol,start              -- backspace removes all (indents, EOLs, start) What is start?

    #   vim.opt.scrolloff = 10                            -- let 10 lines before/after cursor during scroll

    #   vim.opt.clipboard = unnamed                       -- use system clipboard

    #   vim.opt.exrc = true                                    -- enable usage of additional .vimrc files from working directory
    #   vim.opt.secure = true                                  -- prohibit .vimrc files to execute shell, create files, etc...

    #   vim.opt.clipboard = unnamedplus                   -- using system clipboard
    #   vim.opt.wildmode = longest,list                   -- get bash-like tab completions

    #   -- Search settings
    #   vim.opt.incsearch = true                                -- incremental search
    #   vim.opt.hlsearch = true                             -- highlight search results

    #   if vim.g.neovide then
    #      vim.o.guifont = "JetBrains Mono:h9"
    #      vim.g.neovide_cursor_animation_length = 0.01
    #      vim.g.neovide_cursor_trail_size = 0.4
    #   end

    #   vim.g.mapleader = " "

    #   vim.keymap.set("n", "<leader>oe", vim.cmd.Ex)

    #   -- This is going to get me cancelled
    #   vim.keymap.set("i", "jk", "<Esc>")
    #   vim.keymap.set("i", "pw", "<Esc>")

    # '';
  };

  xdg.configFile."nvim/init.lua".onChange = ''
    XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
    for server in $XDG_RUNTIME_DIR/nvim.*; do
      nvim --server $server --remote-send ':source $MYVIMRC<CR>' &
    done
  '';
}
