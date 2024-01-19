{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.optionals config.targets.genericLinux.enable [
    pkgs.nixgl.auto.nixGLDefault
  ];
}
