{pkgs, ...}: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "curved";
        height = 80;
        width = 130;
      };
      open_mapping = "[[<c-t>]]";
      autochdir = true;
      auto_scroll = true;
      close_on_exit = true;
      insert_mappings = true;
      shell = "fish";
    };
  };
  keymaps = [
    {
      key = "<C-t>";
      mode = [
        "n"
        "t"
      ];
      action = "<cmd>ToggleTerm<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
  ];
}
