{ config
, lib
, pkgs
, ...
}: {
  home.packages = [ pkgs.jameica ];
}
