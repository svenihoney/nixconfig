{
  inputs,
  lib,
  ...
}: {
  nix = {
    settings = {
      # substituters = [
      #   "https://cache.m7.rs"
      # ];
      # trusted-public-keys = [
      #   "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
      # ];

      substituters = ["https://cache.nixos.org" "https://nix-community.cachix.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];

      trusted-users = ["root" "@wheel" "@adm"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      system-features = ["kvm" "big-parallel" "nixos-test"];
      flake-registry = ""; # Disable global flake registry
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep the last 3 generations
      options = "--delete-older-than 3d";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    # nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };
  programs.nix-ld.enable = true;
}
