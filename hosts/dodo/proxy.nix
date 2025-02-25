{
  pkgs,
  inputs,
  config,
  ...
}: {
  networking = {
    proxy = {
      default = "http://localhost:8888";
      noProxy = "127.0.0.1,localhost,.software.ads,.infra.rheinmetall.com,chempro.de";
    };
  };

  # YAML is the default
  sops.secrets.proxy_settings = {
    # format = "yaml";
    # can be also set per secret
    sopsFile = ./secrets.yaml;
    # owner = "tinyproxy";
    # mode = "0644";
  };

  # services._3proxy = {
  #   enable = true;
  #   # confFile = "${config.sops.secrets.proxy_settings.path}";
  #   confFile = "/run/credentials/3proxy.service/config";
  # };
  # systemd.services."3proxy".serviceConfig.LoadCredential = "config:${config.sops.secrets."proxy_settings".path}";
  #services.tinyproxy.enable = true;

  networking.firewall = {
    allowedTCPPorts = [8888];
  };
}
