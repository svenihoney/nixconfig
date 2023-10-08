{ pkgs, lib, ... }: {
  home.packages = [ pkgs.sublime-music ];
  home.persistence = {
    "/persist/home/sven".directories = [ ".config/sublime-music" ];
  };
}
