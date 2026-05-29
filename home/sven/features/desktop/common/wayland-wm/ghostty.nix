{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-size = 11;

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
        # "ctrl+]=unbind"
      ];
      # unbind = [
      #   "ctrl+]"
      # ];
      # custom-shader = toString ./ghostty/cursor_smear.glsl;
      custom-shader = toString ./ghostty/cursor_warp.glsl;

      # font-family-bold = "MonaspiceXe Nerd Font Mono";
      # font-family-italic = "MonaspiceRa Nerd Font Mono";
      # font-family-bold-italic = "MonaspiceKr Nerd Font Mono";

      # font-style = "Medium";
      # font-style-bold = "Italic";
      # font-style-italic = "Italic";
      # font-style-bold-italic = "Regular";
    };
  };
}
