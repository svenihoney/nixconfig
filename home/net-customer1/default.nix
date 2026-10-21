{ lib, ... }:
let
in
{
  imports = [
    features/cli/zsh.nix
    features/productivity/ai.nix
  ];

  nix = {
    settings = {
      extra-substituters = lib.mkBefore [
        "https://nix-cache.software.ads/nixos-images"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = lib.mkBefore [
        "nixos-images:gwYWTxv9gqUQmbrMqm+gAjslkRhtWaJPxiXjT15VW9E="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
