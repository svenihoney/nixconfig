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
  ];

  home.packages = with pkgs; [
    zeal
    meld
    kdiff3
    # devenv
  ];

  dconf.settings = {
    "org/gnome/meld" = {
      highlight-current-line = true;
      highlight-syntax = true;
      wrap-mode = "none";
    };
  };
}
