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
      options = {
        desc = "Open Oil file manager";
      };
    }
    {
      mode = ["n"];
      key = "<leader>gg";
      action = "<cmd>Neogit<cr>";
      options = {
        desc = "Open Neogit";
      };
    }
  ];
}
