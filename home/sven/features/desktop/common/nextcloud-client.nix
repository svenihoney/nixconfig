{
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      window_rule = [
        {
          name = "nextcloud";
          float = true;
          match.class = "com.nextcloud.desktopclient.nextcloud";
          move = "(cursor_x) (monitor_h - window_h)";
        }
      ];
    };
  };
}
