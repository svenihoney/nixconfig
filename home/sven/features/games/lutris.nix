{
  pkgs,
  lib,
  ...
}: {
  import = [
    ../desktop/common/wine.nix
  ];
  home.packages = with pkgs; [lutris];

  # home.persistence = {
  #   "/persist/home/${user}" = {
  #     allowOther = true;
  #     directories = [
  #       {
  #         # Use symlink, as games may be IO-heavy
  #         directory = "Games/Lutris";
  #         method = "symlink";
  #       }
  #       ".config/lutris"
  #       ".local/share/lutris"
  #     ];
  #   };
  # };
}
