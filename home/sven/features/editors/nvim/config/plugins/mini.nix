{
  plugins = {
    mini = {
      enable = true;
      modules = {
        icons = {};
        align = {
          mappings = {
            start = "ga";
            start_with_preview = "gA";
          };
        };
        pairs = {};
        surround = {
          mappings = {
            add = "gza"; # Add surrounding in Normal and Visual modes
            delete = "gzd"; # Delete surrounding
            find = "gzf"; # Find surrounding (to the right)
            find_left = "gzF"; # Find surrounding (to the left)
            highlight = "gzh"; # Highlight surroundng
            replace = "gzr"; # Replace surroundng
            update_n_lines = "gzn"; # Update `n_lines`
          };
        };
        ai = {
          n_lines = 500;
          # custom_textobjects = {
          #   o = {
          #     __raw = ''
          #     '';
          #   };
          #   f = {__raw = ''ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {})'';};
          #   c = {__raw = ''ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {})'';};
          #   #   	}
          #   # '';
          # };
        };
        bufremove = {};
        files = {};
      };
      mockDevIcons = true;
    };
  };
  keymaps = [
    # mini.bufremove
    {
      key = "<leader>bd";
      mode = ["n"];
      action = ":lua MiniBufremove.delete(0, false)<CR>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
    {
      key = "<leader>bD";
      mode = ["n"];
      action = ":lua MiniBufremove.delete(0, true)<CR>";
      options = {
        silent = true;
        desc = "Delete buffer (force)";
      };
    }
  ];
}
