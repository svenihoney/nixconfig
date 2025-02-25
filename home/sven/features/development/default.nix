{
  config,
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  imports = [
    ./c.nix
    ./rust.nix
    ./nix.nix
    ./xml.nix
    ./python.nix

    ../editors/emacs
    ../editors/vscode
    #../editors/zed	
  ];

  home.packages = with pkgs;
    [
      zeal
      meld
      kdiff3
      # devenv
    ]
    ++ lib.optionals
    (builtins.hasAttr "devenv" pkgs) [devenv];

  dconf.settings = {
    "org/gnome/meld" = {
      highlight-current-line = true;
      highlight-syntax = true;
      wrap-mode = "none";
    };
  };
}
