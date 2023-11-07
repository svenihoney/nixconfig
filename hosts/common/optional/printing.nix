{
  config,
  lib,
  pkgs,
  ...
}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  # hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "HP MFP M477fnw";
  #       location = "Zu Hause";
  #       deviceUri = "http://192.168.178.2:631/printers/Dell_1250c";
  #       model = "drv:///sample.drv/generic.ppd";
  #       ppdOptions = {
  #         PageSize = "A4";
  #       };
  #     }
  #   ];
  #   ensureDefaultPrinter = "Dell_1250c";
  # };
}
