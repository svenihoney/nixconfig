{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.prismlauncher-qt5];

  home.persistence = {
    "/persist/home/${user}".directories = [".local/share/PrismLauncher"];
  };
}
