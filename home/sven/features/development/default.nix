{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./c.nix
    ./rust.nix
    ./nix.nix
    ./xml.nix
  ];
}
