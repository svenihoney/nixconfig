{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    ulauncher
  ];

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "ulauncher";
      Documentation = [ "man:ulauncher(1)" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
      RestartSec = 3;
      Restart = "always";
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };
}
