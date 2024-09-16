{pkgs, ...}: {
  home.packages = [pkgs.slack];

  wayland.windowManager.hyprland.settings.bind = ["SUPER, F10, exec, ${pkgs.slack}/bin/slack"];

  xdg.mimeApps.defaultApplications = {
    # "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/slack" = "slack.desktop";
  };
}
