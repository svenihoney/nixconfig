{
  # config,
  lib,
  # pkgs,
  ...
}: {
  options.svenihoney.desktop = {
    enable = lib.mkEnableOption "Enable desktop";
  };
}
