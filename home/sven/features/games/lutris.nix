{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ lutris wineWowPackages.waylandFull winetricks ];
  # home.packages = with pkgs; [ lutris wineWowPackages.stable winetricks ];

  # home.persistence = {
  #   "/persist/home/sven" = {
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
