{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../desktop/common/slack.nix
  ];
  home.packages = with pkgs; [tio];
  # home.packages = with pkgs; [qtcreator qt6.full slack tio];

  programs.git.includes = [
    {
      condition = "gitdir:/home/sven/kunden/vorwerk/";
      contents = {user = {email = "sven.fischer@external.vorwerk.com";};};
    }
    {
      condition = "gitdir:/home/sven/kunden/taxdigits/";
      contents = {user = {email = "s.fischer@taxdigits.de";};};
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
