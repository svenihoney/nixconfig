{
  config,
  lib,
  pkgs,
  ...
}: let
  csd = config.svenihoney.devel;
in {
  options.svenihoney.devel = {
    emacs = lib.mkOption {
      description = "Add support for editor emacs";
      default = csd.all;
      type = lib.types.bool;
    };
    nvim = lib.mkOption {
      description = "Add support for editor neovim by nixvim";
      default = true;
      type = lib.types.bool;
    };
    extended = lib.mkEnableOption "Enable support for extended editor features";
    vscode = lib.mkEnableOption "Add support for editor vscode";
    zed = lib.mkEnableOption "Add support for editor zed";
    helix = lib.mkEnableOption "Add support for editor helix";

    copilot = lib.mkEnableOption "Add support for copilot";
  };

  imports = [
    ./emacs
    ./vscode
    ./zed
    ./helix
    ./nvim
    # ./nvf
    # ./lazyvim
  ];
}
