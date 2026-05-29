{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.slack];

  xdg.mimeApps.defaultApplications = {
    # "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/slack" = "slack.desktop";
  };
}
