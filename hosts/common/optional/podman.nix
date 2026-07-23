{
  config,
  pkgs,
  lib,
  ...
}: let
  dockerEnabled = config.virtualisation.docker.enable;
in {
  virtualisation.podman = {
    enable = true;
    dockerCompat = !dockerEnabled;
    dockerSocket.enable = !dockerEnabled;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  environment.systemPackages = with pkgs; [
    skopeo
    buildah
    docker-compose
    passt
  ];

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [53];

  virtualisation.oci-containers.backend = "podman";

  environment.etc."containers/registries.conf" = lib.mkForce {
    text = ''
      unqualified-search-registries = ["docker.io", "quay.io"]
    '';
  };
  # environment.persistence = {
  #   "/persist".directories = [
  #     "/var/lib/containers"
  #   ];
  # };
}
