{lib, config, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # allowedUDPPorts = [41641]; # Facilitate firewall punching
  };
}
