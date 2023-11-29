{ pkgs, lib, ... }: {
  home.packages = [ pkgs.sublime-music ];
  home.persistence = {
    "/persist/home/${user}".directories = [ ".config/sublime-music" ];
  };
}
