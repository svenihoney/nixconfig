{ lib, pkgs, ... }: {
  home = {
    packages = [ pkgs.factorio ];
    persistence = {
      "/persist/home/${user}" = {
        allowOther = true;
        directories = [ ".factorio" ];
      };
    };
  };
}
