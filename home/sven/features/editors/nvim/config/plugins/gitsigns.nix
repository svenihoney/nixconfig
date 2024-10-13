{
  plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add = {
          text = "│";
        };
        change = {
          text = "│";
        };
        changedelete = {
          text = "~";
        };
        delete = {
          text = "_";
        };
        topdelete = {
          text = "‾";
        };
        untracked = {
          text = "┆";
        };
      };
      watch_gitdir = {
        follow_files = true;
      };
    };
  };
}
