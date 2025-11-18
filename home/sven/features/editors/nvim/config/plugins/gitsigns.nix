{
  plugins.gitsigns = {
    enable = true;
    settings = {
      # signs = {
      #   add = {
      #     text = "│";
      #   };
      #   change = {
      #     text = "│";
      #   };
      #   changedelete = {
      #     text = "~";
      #   };
      #   delete = {
      #     text = "_";
      #   };
      #   topdelete = {
      #     text = "‾";
      #   };
      #   untracked = {
      #     text = "┆";
      #   };
      # };
      watch_gitdir = {
        follow_files = true;
      };
      signs = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
        untracked = {
          text = "▎";
        };
      };
      signs_staged = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
      };
    };
  };
  keymaps = [
    {
      key = "<leader>ghb";
      mode = ["n"];
      action = {
        __raw = ''function() require("gitsigns").blame_line({ full = true }) end'';
      };
      options = {
        desc = "Blame line";
      };
    }
    {
      key = "<leader>gb";
      mode = ["n"];
      action = {
        __raw = ''function() require("gitsigns").blame_buffer() end'';
      };
      options = {
        desc = "Blame buffer";
      };
    }
    {
      key = "<leader>ghR";
      mode = ["n"];
      action = {
        __raw = ''function() require("gitsigns").reset_buffer() end'';
      };
      options = {
        desc = "Reset buffer";
      };
    }
    {
      key = "<leader>ghr";
      mode = [
        "n"
        "x"
      ];
      action = ":Gitsigns reset_hunk<CR>";
      options = {
        desc = "Reset hunk";
      };
    }
  ];
}
