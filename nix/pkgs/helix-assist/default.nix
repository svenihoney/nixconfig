{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.buildGoModule {
  pname = "helix-assist";
  version = "1.0.7"; # Aktuelle Version
  src = pkgs.fetchFromGitHub {
    owner = "leona";
    repo = "helix-assist";
    rev = "v1.0.7";
    hash = "sha256-XYbxEGATUiBLJamwrwmAR1UbyTg6A1QcmJyIxagl3g0="; # Mit `nix flake update` ermitteln
  };

  vendorHash = null; # Go modules werden nicht gepinnt
  subPackages = ["cmd/helix-assist"];

  meta = with pkgs.lib; {
    description = "Code assistant language server for Helix";
    license = licenses.mit;
    mainProgram = "helix-assist";
  };
}
