{ config, lib, pkgs, ... }:

{
  programs = {
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = [ "-d 40%" ];
      defaultCommand = "fd --type f";
      defaultOptions = [ "--height 40%" "--border" ];
      changeDirWidgetCommand = "fd --type d"; # alt+c
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [ "--preview 'head {}'" ];
      colors = {
        bg = "#1e1e1e";
        "bg+" = "#1e1e1e";
        fg = "#d4d4d4";
        "fg+" = "#d4d4d4";
      };
    };
  };
}
