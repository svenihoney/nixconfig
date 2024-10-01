{
  imports = [
    ./telescope.nix
    # Development
    ./lsp.nix
    ./treesitter.nix
    ./lualine.nix
    ./cmp.nix
    ./mini.nix
  ];
  plugins = {
    direnv.enable = true;
    which-key.enable = true;
    project-nvim = {
      enable = true;
      enableTelescope = true;
    };
    guess-indent.enable = true; # Guess tabwidth fron indentation in file
    indent-blankline.enable = true; # indentation markers
    lastplace.enable = true; # return to last edit place
    trim.enable = true; # trim whitespace

    oil = {
      enable = true;
      settings.skip_confirm_for_simple_edits = true;
    };
    neogit.enable = true;
    toggleterm = {
      enable = true;
      settings = {
        pen_mapping = "[[<C-t>]]";
        direction = "float";
        # direction                          = "horizontal"; # 'vertical' | 'horizontal' | 'window' | 'float',
        size = 10;
        hide_numbers = true;
        # shade_filetypes                    = {};
        shade_terminals = true;
        shading_factor = 2; # the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true;
        insert_mappings = true; # whether or not the open mapping applies in insert mode
        persist_size = false;
        close_on_exit = true; # close the terminal window when the process exits
      };
    };
  };
  #};
  #   bufferline = {
  #     enable = true;
  #   };
}
