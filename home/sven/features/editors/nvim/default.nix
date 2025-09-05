{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.nvim {
    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = false;

      imports = [./config];
    };
  };
}
