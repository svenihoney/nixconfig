{ pkgs, lib, ... }: {
  home.packages = [ pkgs.osu-lazer ];

  home.persistence = {
    "/persist/home/sven".directories = [ ".local/share/osu" ];
  };
}
