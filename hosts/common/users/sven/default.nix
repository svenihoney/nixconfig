{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # users.mutableUsers = false;
  users.users.sven = {
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
        "dialout"
        "adbusers"
      ];

    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0TbNZWAW4jZmjdrL4RMtuV11k2/0Ya1Mow44CAv0+z sven@leiderfischer.de"];
    # passwordFile = config.sops.secrets.sven-password.path;
    packages = [pkgs.home-manager];
  };

  # sops.secrets.sven-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.sven = import ../../../../home/sven/${config.networking.hostName}.nix;
}
