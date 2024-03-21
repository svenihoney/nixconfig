{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # users.mutableUsers = false;
  users.users.fischer = {
    isNormalUser = true;
    # shell = pkgs.fish;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "minecraft"
        "network"
        "wireshark"
        "i2c"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
        "deluge"
        "networkmanager"
        "scanner"
        "lp"
        "kvm"
        "wireshark"
      ];

    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe/Zxuwysu4HI10NPuDKFxTBqpwVB6HY8i8T1+ynOqh fischer@software.ads"];
    # passwordFile = config.sops.secrets.sven-password.path;
    packages = [pkgs.home-manager];
  };

  # sops.secrets.sven-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.fischer = import ../../../../home/fischer/${config.networking.hostName}.nix;
}
