{pkgs, ...}: {
  imports = [
    # General
    ./snacks.nix
    # ./telescope.nix
    ./mini.nix
    # UI
    ./lualine.nix
    ./which-key.nix
    ./gitsigns.nix
    # Development
    ./lsp.nix
    ./treesitter.nix
    # ./cmp.nix
    ./cmake-tools.nix
    ./dap.nix
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
    indent-blankline = {
      enable = true; # indentation markers
      # settings = let
      #   highlight = ["CursorColumn" "Whitespace"];
      # in {
      #   indent = {
      #     highlight = highlight;
      #     char = "";
      #   };
      #   whitespace = {
      #     highlight = highlight;
      #     remove_blankline_trail = false;
      #   };
      #   scope = {enabled = false;};
      # };
      settings = {
        # indent.char = "·";
        indent.char = "│";
      };
    };
    lastplace.enable = true; # return to last edit place
    trim.enable = true; # trim whitespace
    illuminate.enable = true; # highlight same keywords

    oil = {
      enable = true;
      settings.skip_confirm_for_simple_edits = true;
    };
    neogit.enable = true;
    ts-comments = {
      # lazyLoad.enable = true;
      enable = true;
    };
    flash = {
      enable = true;
      settings = {
        modes.search.enable = true;
        # modes.char.jump_labels = true;
      };
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
  };
  extraPlugins = with pkgs.vimPlugins; [
    # For these no nixvim plugin exists
    vim-abolish
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-compile-mode";
      # src = vim-compile-mode;
      src = pkgs.fetchFromGitHub {
        owner = "ej-shafran";
        repo = "compile-mode.nvim";
        rev = "d436d8f11f156de619baba72cd1fbc4216586cd6";
        hash = "sha256-T2l/lEOiO+X5TfAT1mcsyg307nktT+YxxlpbCloNLp4=";
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
      mode = ["n"];
      key = "gss";
      action = "<cmd>lua require(\"flash\").jump()<CR>";
      options = {
        desc = "Jump to character";
      };
    }
    {
      mode = ["n"];
      key = "gst";
      action = "<cmd>lua require(\"flash\").treesitter()<CR>";
      options = {
        desc = "Jump to object";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<F7>";
      action = "<cmd>wa<CR><cmd>Recompile<CR>";
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
      action = "<cmd>Compile<CR>";
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
      action = "<cmd>Compile<CR>";
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
      action = "<cmd>Compile<CR>";
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
  ];
  #};
  #   bufferline = {
  #     enable = true;
  #   };
}
