{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.rust {
    home.packages = with pkgs; [
      # rustc
      rust-analyzer
    ];
  };
}
