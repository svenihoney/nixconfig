{
  config,
  pkgs,
  ...
}: let
  dockerEnabled = config.virtualisation.docker.enable;
in {
  virtualisation.podman = {
    enable = true;
    dockerCompat = !dockerEnabled;
    dockerSocket.enable = !dockerEnabled;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    skopeo
    buildah
    docker-compose
    passt
  ];
  # environment.persistence = {
  #   "/persist".directories = [
  #     "/var/lib/containers"
  #   ];
  # };
}
