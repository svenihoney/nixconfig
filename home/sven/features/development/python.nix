{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.python {
    home.packages = with pkgs; [
      python3
      # pyright
      basedpyright
    ];
  };
}
