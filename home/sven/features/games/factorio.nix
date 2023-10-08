{ lib, pkgs, ... }: {
  home = {
    packages = [ pkgs.factorio ];
    persistence = {
      "/persist/home/sven" = {
        allowOther = true;
        directories = [ ".factorio" ];
      };
    };
  };
}
