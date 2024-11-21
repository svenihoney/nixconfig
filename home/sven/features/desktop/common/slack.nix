{pkgs, ...}: {
  home.packages = [pkgs.slack];

  # wayland.windowManager.hyprland.settings.bind = ["SUPER, F10, exec, ${pkgs.slack}/bin/slack"];
  # wayland.windowManager.hyprland.settings.bind = ["SUPER, F10, exec, $HOME/.nix-profile/bin/slack"];
  wayland.windowManager.hyprland.settings.bind = ["SUPER, F10, exec, $HOME/.nix-profile/bin/slack" "SUPER SHIFT, F10, exec, echo ozone: $NIXOS_OZONE_WL >/tmp/foo"];

  xdg.mimeApps.defaultApplications = {
    # "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/slack" = "slack.desktop";
  };
}
