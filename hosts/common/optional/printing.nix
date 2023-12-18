{ config
, lib
, pkgs
, ...
}: {
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  services.avahi = {
    enable = true;
    # nssmdns = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
}
