{
  keymaps = [
    {
      mode = ["i" "n"];
      key = "<esc>";
      action = "<cmd>noh<CR><esc>";
      options = {
        desc = "Escape clears hlsearch highlights";
        #   silent = true;
      };
    }
    # Undo breakpoints
    {
      mode = ["i"];
      key = ",";
      action = ",<c-g>u";
    }
    {
      mode = ["i"];
      key = ".";
      action = ".<c-g>u";
    }
    {
      mode = ["i"];
      key = ";";
      action = ";<c-g>u";
    }
    # Sane next and previous
    {
      mode = ["n" "x" "o"];
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        desc = "Next search result";
      };
    }
    {
      mode = ["n" "x" "o"];
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        desc = "Prev search result";
      };
    }
    # Open
    {
      mode = ["n"];
      key = "<leader>o-";
      action = "<cmd>Oil<cr>";
      # action = "<cmd>:lua MiniFiles.open()<cr>";
      options = {
        desc = "Open file manager";
      };
    }
    # Git
    {
      mode = ["n"];
      key = "<leader>gg";
      action = "<cmd>Neogit<cr>";
      options = {
        desc = "Open Neogit";
      };
    }
    # Maximize window
    {
      mode = ["n"];
      key = "<leader>wm";
      action = "<C-w>T";
      options = {
        desc = "Maximize window";
      };
    }
    # Reselect on indentation
    {
      mode = ["v"];
      key = ">";
      action = ">gv";
      options = {
        desc = "Indent lines";
      };
    }
    {
      mode = ["v"];
      key = "<";
      action = "<gv";
      options = {
        desc = "Unindent lines";
      };
    }
  ];
}
