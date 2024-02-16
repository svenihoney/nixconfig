{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qtcreator qt6.full teams-for-linux slack];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/slack" = "slack.desktop";
  };

  programs.git.includes = [
    {
      condition = "gitdir:/home/sven/kunden/vorwerk/";
      contents = {user = {email = "Sven.Fischer@external.vorwerk.com";};};
    }
  ];
}
