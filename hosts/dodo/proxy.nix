{
  pkgs,
  inputs,
  config,
  ...
}: {
  networking = {
    proxy = {
      default = "http://localhost:8888";
      noProxy = "127.0.0.1,localhost,.software.ads";
    };
  };

  # YAML is the default
  sops.secrets.proxy_settings = {
    # format = "yaml";
    # can be also set per secret
    sopsFile = ./secrets.yaml;
    owner = "tinyproxy";
    mode = "0600";
  };
  sops.secrets.filter_settings = {
    # format = "yaml";
    # can be also set per secret
    sopsFile = ./secrets.yaml;
    owner = "tinyproxy";
    mode = "0600";
  };
  services.tinyproxy = {enable = true;};

  systemd.services.tinyproxy.serviceConfig.ExecStart = let
    configFile = config.sops.secrets.proxy_settings.path;
  in
    pkgs.lib.mkForce "${pkgs.tinyproxy}/bin/tinyproxy -d -c ${configFile}";

  networking.firewall = {
    allowedTCPPorts = [8888];
  };
}
