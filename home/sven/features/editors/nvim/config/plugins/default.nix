{
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
  ];
  plugins = {
    direnv.enable = true;
    project-nvim = {
      enable = true;
      enableTelescope = true;
    };
    guess-indent.enable = true; # Guess tabwidth fron indentation in file
    indent-blankline.enable = true; # indentation markers
    lastplace.enable = true; # return to last edit place
    trim.enable = true; # trim whitespace
    illuminate.enable = true; # hightlight same keywords

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
    flash = {
      enable = true;
      settings = {
        modes.search.enable = true;
        modes.char.jump_labels = true;
      };
    };
  };
  #};
  #   bufferline = {
  #     enable = true;
  #   };
}
