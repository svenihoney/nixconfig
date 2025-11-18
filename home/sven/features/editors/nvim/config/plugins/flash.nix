{
  plugins.flash = {
    enable = true;
    settings = {
      modes.search.enable = true;
      # modes.char.jump_labels = true;
      labels = "haeiudtrnsfk.o,yvgclßzxqäüöbpwmj";
    };
  };
  keymaps = [
    # Other keymaps
    {
      mode = ["n" "x" "o"];
      key = "gss";
      action = "<cmd>lua require(\"flash\").jump()<CR>";
      options = {
        desc = "Jump to character";
      };
    }
    {
      mode = ["n" "x" "o"];
      key = "s";
      action = "<cmd>lua require(\"flash\").jump()<CR>";
      options = {
        desc = "Jump to character";
      };
    }
    {
      mode = ["n" "x" "o"];
      key = "S";
      action = "<cmd>lua require(\"flash\").treesitter()<CR>";
      options = {
        desc = "Jump to object";
      };
    }
  ];
}
