{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      keepassxc
    ];

  systemd.user.services.keepassxc = {
    Unit = {
      Description = "keepassxc";
      Documentation = [ "man:keepassxc(1)" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
      RestartSec = 3;
      Restart = "always";
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };

}
