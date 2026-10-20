{
  pkgs,
  ...
}:
{
  programs = {
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = [ "-d 40%" ];
      defaultCommand = "fd --type f --hidden --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--border"
        "--layout=reverse"
      ];
      changeDirWidget = {
        command = "fd --type d"; # alt+c
        options = [ "--preview 'tree -C {} | head -200'" ];
      };
      fileWidget = {
        command = "fd --type f";
        options = [ "--preview 'head {}'" ];
      };
      historyWidget.command = "";
    };
    tmux.enable = true;
    fish = {
      plugins = [
        {
          name = "fifc";
          src = pkgs.fishPlugins.fifc.src;
        }
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };
  };
}
