{
  config,
  pkgs,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
    # acceleration = "rocm";
    # environmentVariables = {
    #   HCC_AMDGPU_TARGET = "gfx1030"; # used to be necessary, but doesn't seem to anymore
    # };
    # rocmOverrideGfx = "10.3.0";
  };
  home.packages = [pkgs.oterm pkgs.alpaca];
}
