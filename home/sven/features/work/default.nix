{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [slack tio];
  # home.packages = with pkgs; [qtcreator qt6.full slack tio];

  xdg.mimeApps.defaultApplications = {
    # "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/slack" = "slack.desktop";
  };

  programs.git.includes = [
    {
      condition = "gitdir:/home/sven/kunden/vorwerk/";
      contents = {user = {email = "sven.fischer@external.vorwerk.com";};};
    }
  ];

  home.file.".config/tio/config" = {
    text = ''
      [cosy]
      device = /dev/serial/by-id/usb-FTDI_Dual_RS232-HS-if00-port0
      baudrate = 115200

      [tm6]
      device = /dev/serial/by-id/usb-FTDI_TTL232R-3V3_FT9JAOCH-if00-port0
      baudrate = 115200
    '';
  };
}
