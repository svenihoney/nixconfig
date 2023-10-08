{ pkgs, lib, ... }: {
  home.packages = [ pkgs.prismlauncher-qt5 ];

  home.persistence = {
    "/persist/home/sven".directories = [ ".local/share/PrismLauncher" ];
  };
}
