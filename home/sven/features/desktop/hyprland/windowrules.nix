{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        name = "windowrule-3";
        float = true;
        match.class = "org.keepassxc.KeePassXC";
      }
      {
        name = "windowrule-4";
        float = true;
        match.class = "com.saivert.pwvucontrol";
      }
      # {
      #   name = "windowrule-5";
      #   float = true;
      #   match.class = "(org.speedcrunch.)";
      # }
      # {
      #   name = "windowrule-6";
      #   float = true;
      #   move = "(cursor_x+(min(max(0,0),monitor_w-window_w))) (cursor_y+(min(max(0,0),monitor_h-window_h)))";
      #   match.class = "com.github.hluk.copyq";
      # }
      {
        name = "windowrule-7";
        float = true;
        match.class = "com.gabm.satty";
      }
      # {
      #   name = "windowrule-8";
      #   float = true;
      #   move = "(cursor_x+(min(max((monitor_w*0.5),0),monitor_w-window_w))) (cursor_y+(min(max((monitor_h*0.5),0),monitor_h-window_h)))";
      #   match.class = "com.nextcloud.desktopclient.nextcloud";
      # }
      {
        name = "windowrule-9";
        float = true;
        match.title = "(twinkle)";
      }
      {
        name = "windowrule-10";
        float = true;
        match.title = "Bluetooth Devices";
      }
      # {
      #   name = "windowrule-11";
      #   float = true;
      #   match.title = "Netxp.*";
      # }
      {
        name = "windowrule-12";
        workspace = "2";
        match.class = "([Vv]ivaldi.*)";
      }
      {
        name = "windowrule-13";
        workspace = "2";
        match.class = "(org.qutebrowser.qutebrowser)";
      }
      {
        name = "windowrule-14";
        workspace = "2";
        match.class = "firefox";
      }
      {
        name = "windowrule-15";
        workspace = "2";
        match.class = "zen.*";
      }
      {
        name = "windowrule-16";
        workspace = "3";
        match.class = "thunderbird";
      }
      {
        name = "windowrule-17";
        float = true;
        match.title = "(Kalendererinnerungen)";
      }
      {
        name = "windowrule-18";
        workspace = "7";
        match.class = "spotify";
      }
      {
        name = "windowrule-19";
        workspace = "7";
        match.title = "(Amazon Music Unlimited.*)";
      }
      {
        name = "windowrule-20";
        workspace = "10";
        match.class = "Slack";
      }
      {
        name = "windowrule-21";
        float = true;
        match.title = "Wargaming.net Game Center";
      }
      {
        name = "windowrule-22";
        fullscreen = true;
        match.title = "W.o.T. Client";
      }
      {
        name = "windowrule-23";
        float = true;
        match.title = ".*Huddle.*";
      }
      {
        name = "windowrule-24";
        match.title = "Verfassen:.*";
        float = true;
        center = true;
        size = "1000 1000";
        # min_size = "{ 600, 800 }";
        dim_around = true;
      }
      {
        name = "windowrule-25";
        match.title = "Slint Window";
        float = true;
        # center = true;
        size = "1920 1200";
        # min_size = "{ 600, 800 }";
        # dim_around = true;
      }
    ];
  };
}
