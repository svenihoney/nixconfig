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

      # Don't build the Nixvim option man-pages: generating them forces
      # evaluation of the whole option tree (and Nixvim's own pinned nixpkgs).
      enableMan = false;
      # Reuse the host configuration's pkgs instead of instantiating a second
      # nixpkgs just for Nixvim. This roughly halves evaluation time.
      nixpkgs.useGlobalPackages = true;

      imports = [./config];
    };
  };
}
