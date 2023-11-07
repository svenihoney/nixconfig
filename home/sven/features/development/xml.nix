{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libxslt
    libxml2
  ];
}
