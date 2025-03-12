{pkgs, ...}: {
  imports = [
    # General
    ./telescope.nix
    ./mini.nix
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
  ];
  plugins = {
    lz-n.enable = true;
    direnv.enable = true;
    project-nvim = {
      enable = true;
      enableTelescope = true;
    };
    guess-indent.enable = true; # Guess tabwidth from indentation in file
    indent-blankline.enable = true; # indentation markers
    lastplace.enable = true; # return to last edit place
    trim.enable = true; # trim whitespace
    illuminate.enable = true; # highlight same keywords

    oil = {
      enable = true;
      settings.skip_confirm_for_simple_edits = true;
    };
    neogit.enable = true;
    toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<C-\>]]";
        direction = "float";
        float_opts = {
          border = "curved";
        };
      };
    };
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
        rev = "8dff8d8472363e01499a4e8cc02f5f5595ce3922";
        hash = "sha256-wkiKD+TWE40blMk48Vg2UTBpeSQL0QOpq1Rba9arGOo=";
      };
      dependencies = [plenary-nvim baleia-nvim];
    })
  ];
  extraConfigLua = ''
    vim.g.compile_mode = {
      default_command = "cmake --build build",
      ask_about_save = false,
      baleia_setup = true,
    }
  '';

  keymaps = [
    {
      mode = ["n"];
      key = "\\";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "Toggle terminal";
      };
    }
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
      mode = ["n" "v"];
      key = "<F7>";
      action = "<cmd>wa<CR><cmd>Recompile<CR>";
      options = {
        desc = "Recompile sources";
      };
    }
    {
      mode = ["n" "v"];
      # key = "<S-F7>";
      key = "<F19>";
      action = "<cmd>Compile<CR>";
      options = {
        desc = "Run a compilation";
      };
    }
    {
      mode = ["n" "v"];
      key = "<F8>";
      action = "<cmd>NextError<CR>";
      options = {
        desc = "Jump to next error";
      };
    }
    {
      mode = ["n" "v"];
      key = "<F20>";
      action = "<cmd>PrevError<CR>";
      options = {
        desc = "Jump to previous error";
      };
    }
  ];
  #};
  #   bufferline = {
  #     enable = true;
  #   };
}
