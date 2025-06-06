{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-size = 10;

      gtk-tabs-location = "bottom";
      gtk-titlebar = false;
      # theme = "Dracula";

      # shell-integration = fish;
      shell-integration-features = "no-cursor";
      window-inherit-working-directory = true;
      clipboard-paste-protection = false;

      mouse-hide-while-typing = true;
      scrollback-limit = 80000000;

      keybind = [
        "ctrl+shift+h=write_scrollback_file:open"
      ];
    };
  };
  # home = {
  #   packages = [pkgs.ghostty];
  #   sessionVariables = {
  #     TERMINAL = "ghostty";
  #   };
  # };

  # # home.file."${config.xdg.configHome}/ghostty/config" = {
  # home.file.".config/ghostty/config" = {
  #   text = ''
  #     font-size = 10

  #     gtk-tabs-location = bottom
  #     gtk-titlebar = false
  #     theme = Dracula

  #     shell-integration = fish
  #     shell-integration-features = no-cursor
  #     window-inherit-working-directory = true
  #     clipboard-paste-protection = false

  #     mouse-hide-while-typing = true
  #     scrollback-limit = 80000000

  #     keybind = ctrl+shift+h=write_scrollback_file:open
  #   '';
  # };
}
