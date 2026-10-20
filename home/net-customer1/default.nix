{ lib, ... }:
let
in
{
  imports = [
    common/features/cli/zsh.nix
  ];

  nix = {
    settings = {
      substituters = lib.mkBefore [
        "https://nix-cache.software.ads/nixos-images"
      ];
      trusted-public-keys = lib.mkBefore [
        "nixos-images:wTU650Sa2OxMeyU/ERWGmAiGC/dGCGBdO3ZlN9zoB8Q="
      ];
    };
  };
}
