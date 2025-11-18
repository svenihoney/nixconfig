{pkgs, ...}: {
  imports = [
    # General
    ./snacks.nix
    # ./telescope.nix
    ./mini.nix
    ./flash.nix
    # UI
    ./lualine.nix
    ./which-key.nix
    ./gitsigns.nix
    # Development
    ./lsp.nix
    ./treesitter.nix
    ./cmp.nix
    ./cmake-tools.nix
    ./dap.nix
    ./trouble.nix
    # ./codecompanion.nix
    ./ai.nix
    ./toggleterm.nix
    # ./copilot.nix
  ];
  plugins = {
    lz-n.enable = true;
    direnv.enable = true;
    project-nvim = {
      enable = true;
      # enableTelescope = true;
    };
    guess-indent.enable = true; # Guess tabwidth from indentation in file
    # indent-blankline = {
    #   enable = true; # indentation markers
    #   settings = {
    #     indent.char = "│";
    #   };
    # };
    lastplace.enable = true; # return to last edit place
    trim.enable = true; # trim whitespace
    illuminate.enable = true; # highlight same keywords

    oil = {
      enable = true;
      settings.skip_confirm_for_simple_edits = true;
    };
    neogit.enable = true;
    grug-far.enable = true;
    ts-comments = {
      # lazyLoad.enable = true;
      enable = true;
    };
    firenvim.enable = true;
    yanky = {
      enable = true;
      autoLoad = true;
    };
    noice = {
      enable = true;
      autoLoad = true;
    };
    # leap.enable = true;
  };
  extraPlugins = with pkgs.vimPlugins; [
    # For these no nixvim plugin exists
    vim-abolish # Automatic case in search and replace
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-compile-mode";
      # src = vim-compile-mode;
      src = pkgs.fetchFromGitHub {
        owner = "ej-shafran";
        repo = "compile-mode.nvim";
        rev = "0b2a059baa734da932913f555eb157637dab5cdd";
        hash = "sha256-kfZ6/8m0i8pQn0E9U9XK3dUshcR0No1P3iM5maCnvX0=";
      };
      dependencies = [
        plenary-nvim
        baleia-nvim
      ];
    })
  ];
  extraConfigLua = ''
    vim.g.compile_mode = {
      default_command = "cmake --build build",
      ask_about_save = false,
      baleia_setup = true,
      bang_expansion = true,
      -- use_diagnostics = true,
    }
  '';

  keymaps = [
    # Other keymaps
    {
      mode = [
        "n"
        "v"
      ];
      key = "<F7>";
      action = "<cmd>wa<CR><cmd>bd \*compilation\*<CR><cmd>20Recompile<CR>";
      options = {
        desc = "Recompile sources";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<S-F7>";
      action = "<cmd>20Compile<CR>";
      options = {
        desc = "Run a compilation";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>pc";
      action = "<cmd>20Compile<CR>";
      options = {
        desc = "Run a compilation";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      # key = "<S-F7>" for terminal
      key = "<F19>";
      action = "<cmd>20Compile<CR>";
      options = {
        desc = "Run a compilation";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<F8>";
      action = "<cmd>NextError<CR>";
      options = {
        desc = "Jump to next error";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<S-F8>";
      action = "<cmd>PrevError<CR>";
      options = {
        desc = "Jump to previous error";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      # key = "<S-F8>" for terminal
      key = "<F20>";
      action = "<cmd>PrevError<CR>";
      options = {
        desc = "Jump to previous error";
      };
    }
    {
      mode = ["n"];
      key = "<leader>ps";
      action = "<cmd>wa<CR>";
      options = {
        desc = "Save all files in project";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>yh";
      action = "<cmd>YankyRingHistory<CR>";
      options = {
        desc = "Open Yank History";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sr";
      action = {
        __raw = ''
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end
        '';
      };
      options = {
        desc = "Open Yank History";
      };
    }
  ];
  #};
  #   bufferline = {
  #     enable = true;
  #   };
}
