{
  config,
  lib,
  pkgs,
  ...
}: let
  csd = config.svenihoney.devel;
in {
  options.svenihoney.devel = {
    all = lib.mkOption {
      description = "Add development tools for all languages";
      default = false;
      type = lib.types.bool;
    };

    c = lib.mkOption {
      description = "Add development tools for C/C++";
      default = csd.all;
      type = lib.types.bool;
    };

    rust = lib.mkOption {
      description = "Add development tools for Rust";
      default = csd.all;
      type = lib.types.bool;
    };

    xml = lib.mkOption {
      description = "Add development tools for XML";
      default = csd.all;
      type = lib.types.bool;
    };

    python = lib.mkOption {
      description = "Add development tools for Python";
      default = csd.all;
      type = lib.types.bool;
    };

    emacs = lib.mkOption {
      description = "Add support for editor emacs";
      default = csd.all;
      type = lib.types.bool;
    };
    vscode = lib.mkEnableOption "Add support for editor vscode";
    zed = lib.mkEnableOption "Add support for editor zed";
    helix = lib.mkEnableOption "Add support for editor helix";

    copilot = lib.mkEnableOption "Add support for copilot";
  };

  imports = [
    ./nix.nix

    ./c.nix
    ./rust.nix
    ./xml.nix
    ./python.nix

    ../editors/emacs
    ../editors/vscode
    ../editors/zed
    ../editors/helix
  ];
  config = with lib.hm; {
    # lib.hm.home.packages = with pkgs; [
    home.packages = with pkgs; [
      meld
      kdiff3
      devenv
    ];
    # ++ lib.optionals
    # (builtins.hasAttr "devenv" pkgs) [devenv];
    lib.hm.gvariant.dconf.settings = {
      "org/gnome/meld" = {
        highlight-current-line = true;
        highlight-syntax = true;
        wrap-mode = "none";
      };
    };
    programs.nixvim.plugins.lsp.servers = {
      clangd.enable = config.svenihoney.devel.c;
      # extraOptions = "--log=verbose";
      # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd" "--log=verbose"];
      # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd"];
      # extraOptions = { log = "verbose"; };
      basedpyright.enable = config.svenihoney.devel.python;
      ruff.enable = config.svenihoney.devel.python;
      rust_analyzer = {
        enable = config.svenihoney.devel.rust;
        installRustc = false;
        installCargo = false;
      };
    };
  };
}
