{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.xml {
    home.packages = with pkgs; [
      libxslt
      libxml2
    ];
  };
}
