{
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        {
          "name" = "nextcloud";
          "float" = "on";
          "match:class" = "com.nextcloud.desktopclient.nextcloud";
          "move" = "(cursor_x) (monitor_h - window_h)";
        }
      ];
    };
  };
}
