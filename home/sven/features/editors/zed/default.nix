{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.zed-editor];
}
