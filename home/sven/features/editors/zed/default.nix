{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.zed {
    home.packages = [pkgs.zed-editor];
  };
}
