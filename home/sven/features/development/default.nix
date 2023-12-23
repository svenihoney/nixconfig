{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./c.nix
    ./rust.nix
    ./nix.nix
    ./xml.nix
    ./python.nix
  ];

  home.packages = with pkgs; [ zeal meld kdiff3 ];
}
