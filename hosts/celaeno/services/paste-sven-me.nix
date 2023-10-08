{ config, inputs, pkgs, ... }: {
  imports = [
    inputs.paste-sven-me.nixosModules.server
  ];

  services = {
    paste-sven-me = {
      enable = true;
      package = pkgs.inputs.paste-sven-me.server;
      database.createLocally = true;
      environmentFile = config.sops.secrets.paste-sven-me-secrets.path;
      port = 8082;
    };

    nginx.virtualHosts."paste.sven.me" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass =
        "http://localhost:${toString config.services.paste-sven-me.port}";
    };
  };

  sops.secrets.paste-sven-me-secrets = {
    owner = "paste";
    group = "paste";
    sopsFile = ../secrets.yaml;
  };
}
