{
  plugins = {
    telescope = {
      enable = true;
      settings = {
        pickers.colorscheme.enable_preview = true;
        file_ignore_patterns = ["node_modules"];
        # defaults = {
        #   prompt_prefix = " ";
        #   selection_caret = "❯ ";
        #   path_display = [
        #     "truncate"
        #   ];
        #   sorting_strategy = "ascending";
        #   layout_config = {
        #     horizontal = {
        #       prompt_position = "top";
        #       preview_width = 0.55;
        #     };
        #     vertical = {
        #       mirror = false;
        #     };
        #     width = 0.87;
        #     height = 0.80;
        #     preview_cutoff = 120;
        #   };
        # };
      };
      extensions = {
        fzf-native.enable = true;
        manix.enable = true;
      };
      keymaps = {
        "<leader><leader>" = "find_files";
        "<leader>ff" = "find_files";
        "<leader>fr" = "oldfiles";
        "<leader>sp" = "live_grep";
        "<leader>ss" = "current_buffer_fuzzy_find";
        "<leader>*" = "grep_string";
        "<leader>bb" = "buffers";
        "<leader>fh" = "help_tags";
      };
    };

    # web-devicons.enable = true;
  };
}
