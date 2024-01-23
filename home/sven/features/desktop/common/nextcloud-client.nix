{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nextcloud-client
  ];

  systemd.user.services.nextcloud = {
    Unit = {
      Description = "nextcloud";
      Documentation = ["man:nextcloud(1)"];
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background";
      RestartSec = 3;
      Restart = "always";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
  };
}
