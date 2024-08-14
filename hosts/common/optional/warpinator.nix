{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.firewall = lib.mkIf (lib.elem pkgs.warpinator config.home-manager.users.sven.home.packages) {
    # checkReversePath = "loose";
    allowedTCPPorts = [42000 42001]; # Facilitate firewall punching
    allowedUDPPorts = [5353 42000 42001];
  };
}
