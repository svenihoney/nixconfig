{pkgs, ...}: {
  home.packages = with pkgs; [musescore];

  # services.fluidsynth = {
  #   enable = true;
  #   soundService = "pipewire-pulse";
  #   extraOptions = [
  #     "-g 2"
  #   ];
  # };
}
