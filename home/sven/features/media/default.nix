{pkgs, ...}: {
  imports = [
    ../desktop/common/mpv.nix
  ];
  home.packages = with pkgs; [alsa-utils];

  # }
  #   services.fluidsynth = {
  #     enable = true;
  #     soundService = "pipewire-pulse";
  #     extraOptions = [
  #       "-g 2"
  #     ];
  #   };
}
