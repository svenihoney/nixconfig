{lib, config, ...}: {
  services.tailscale = {
    enable = lib.mkDefault false;
    useRoutingFeatures = lib.mkDefault "client";
  };
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # allowedUDPPorts = [41641]; # Facilitate firewall punching
  };
}
