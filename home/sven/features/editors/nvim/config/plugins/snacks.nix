{
  plugins = {
    snacks = {
      enable = true;
      settings = {
        picker = {
          enabled = true;
          win = {
            input = {
              keys = {
                "<Esc>" = "close";
                "<C-c>" = "close";
              };
            };
          };
        };
      };
    };
  };
  keymaps = [
    # Snacks picker keymaps
    {
      mode = ["n"];
      key = "<leader><leader>";
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options = {
        desc = "Find files";
      };
    }
    {
      mode = ["n"];
      key = "<leader>ff";
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options = {
        desc = "Find files";
      };
    }
    {
      mode = ["n"];
      key = "<leader>fr";
      action = "<cmd>lua Snacks.picker.recent()<CR>";
      options = {
        desc = "Recent files";
      };
    }
    {
      mode = ["n"];
      key = "<leader>sp";
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      options = {
        desc = "Live grep";
      };
    }
    {
      mode = ["n"];
      key = "<leader>ss";
      action = "<cmd>lua Snacks.picker.lines()<CR>";
      options = {
        desc = "Grep";
      };
    }
    {
      mode = ["n"];
      key = "<leader>*";
      action = "<cmd>lua Snacks.picker.grep_word()<CR>";
      options = {
        desc = "Grep word under cursor";
      };
    }
    {
      mode = ["n"];
      key = "<leader>bb";
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      options = {
        desc = "Buffers";
      };
    }
    {
      mode = ["n"];
      key = "<leader>fh";
      action = "<cmd>lua Snacks.picker.help()<CR>";
      options = {
        desc = "Help";
      };
    }
    # Project selection
    {
      mode = ["n"];
      key = "<leader>pp";
      action = "<cmd>lua Snacks.picker.projects()<CR>";
      options = {
        desc = "Select project";
      };
    }
  ];
}
