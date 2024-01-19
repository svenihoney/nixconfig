{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.osu-lazer];

  home.persistence = {
    "/persist/home/${user}".directories = [".local/share/osu"];
  };
}
