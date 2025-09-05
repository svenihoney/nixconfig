{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix

    ./c.nix
    ./rust.nix
    ./xml.nix
    ./python.nix

    # ../editors/emacs
    # ../editors/vscode
    # ../editors/zed
    # ../editors/helix
  ];
  config = with lib.hm; {
    # lib.hm.home.packages = with pkgs; [
    home.packages = with pkgs;
      [
        devenv
      ]
      ++ (lib.optionals config.svenihoney.desktop.enable [
        meld
        kdiff3
      ]);
    # ++ lib.optionals
    # (builtins.hasAttr "devenv" pkgs) [devenv];
    lib.hm.gvariant.dconf.settings = {
      "org/gnome/meld" = {
        highlight-current-line = true;
        highlight-syntax = true;
        wrap-mode = "none";
      };
    };
    # programs.nixvim.plugins.lsp.servers = {
    #   clangd.enable = config.svenihoney.devel.c;
    #   # extraOptions = "--log=verbose";
    #   # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd" "--log=verbose"];
    #   # cmd = ["/opt/veld/2.0.0/sysroots/x86_64-pokysdk-linux/usr/bin/clangd"];
    #   # extraOptions = { log = "verbose"; };
    #   basedpyright.enable = config.svenihoney.devel.python;
    #   ruff.enable = config.svenihoney.devel.python;
    #   rust_analyzer = {
    #     enable = config.svenihoney.devel.rust;
    #     installRustc = false;
    #     installCargo = false;
    #   };
    # };
  };
}
