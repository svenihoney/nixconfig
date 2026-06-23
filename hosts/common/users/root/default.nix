{
  pkgs,
  config,
  lib,
  ...
}:
  {
  # users.mutableUsers = false;
  users.users.root = {
    shell = pkgs.fish;
    # passwordFile = config.sops.secrets.sven-password.path;
  };

  # sops.secrets.sven-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.root = import ../../../../home/root;
}
