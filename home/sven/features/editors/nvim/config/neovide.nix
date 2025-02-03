{
  extraConfigLuaPost = ''
    if vim.g.neovide then
        vim.o.guifont = "JetBrainsMono Nerd Font:h8"
        vim.g.neovide_cursor_animation_length = 0.01
        vim.g.neovide_cursor_trail_size = 0.4
    end
  '';
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<C-.>";
      action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
    }
    {
      mode = ["n" "v"];
      key = "<C-,>";
      action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>";
    }
    {
      mode = ["n" "v"];
      key = "<C-->";
      action = ":lua vim.g.neovide_scale_factor = 1<CR>";
    }
  ];
}
