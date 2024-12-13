{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 40%"];
      defaultCommand = "fd --type f";
      defaultOptions = ["--height 40%" "--border"];
      changeDirWidgetCommand = "fd --type d"; # alt+c
      changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = ["--preview 'head {}'"];
    };
    fish = {
      plugins = [
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };
  };
}
