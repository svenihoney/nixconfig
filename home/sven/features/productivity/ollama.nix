{
  config,
  pkgs,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
  };
  home.packages = [pkgs.oterm];
}
