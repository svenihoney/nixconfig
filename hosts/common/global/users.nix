{ pkgs, config, lib, hostname, outputs, ... }:
let
  inherit (lib) mkDefault optional;
  homeConfig = outputs.homeConfigurations."misterio@${hostname}".config;
in
{
  users.mutableUsers = false;
  users.users = {
    misterio = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "video"
        "audio"
      ]
      ++ (optional config.networking.networkmanager.enable "networkmanager")
      ++ (optional config.programs.wireshark.enable "wireshark")
      ++ (optional config.hardware.i2c.enable "i2c")
      ++ (optional config.services.deluge.enable "deluge")
      ++ (optional config.services.minecraft-server.enable "minecraft")
      ++ (optional config.services.mysql.enable "mysql")
      ++ (optional config.virtualisation.docker.enable "docker")
      ++ (optional config.virtualisation.podman.enable "podman")
      ++ (optional config.virtualisation.libvirtd.enable "libvirtd");

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDci4wJghnRRSqQuX1z2xeaUR+p/muKzac0jw0mgpXE2T/3iVlMJJ3UXJ+tIbySP6ezt0GVmzejNOvUarPAm0tOcW6W0Ejys2Tj+HBRU19rcnUtf4vsKk8r5PW5MnwS8DqZonP5eEbhW2OrX5ZsVyDT+Bqrf39p3kOyWYLXT2wA7y928g8FcXOZjwjTaWGWtA+BxAvbJgXhU9cl/y45kF69rfmc3uOQmeXpKNyOlTk6ipSrOfJkcHgNFFeLnxhJ7rYxpoXnxbObGhaNqn7gc5mt+ek+fwFzZ8j6QSKFsPr0NzwTFG80IbyiyrnC/MeRNh7SQFPAESIEP8LK3PoNx2l1M+MjCQXsb4oIG2oYYMRa2yx8qZ3npUOzMYOkJFY1uI/UEE/j/PlQSzMHfpmWus4o2sijfr8OmVPGeoU/UnVPyINqHhyAd1d3Iji3y3LMVemHtp5wVcuswABC7IRVVKZYrMCXMiycY5n00ch6XTaXBwCY00y8B3Mzkd7Ofq98YHc= (none)"
      ];
      passwordFile = config.sops.secrets.misterio-password.path;
    };
  };

  sops.secrets.misterio-password = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };


  services.geoclue2.enable = mkDefault (
    (homeConfig.services.gammastep.enable or false) &&
    (homeConfig.services.gammastep.provider == "geoclue2")
  );
  security.pam.services.swaylock = { };
}