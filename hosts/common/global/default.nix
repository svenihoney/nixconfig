# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      # inputs.home-manager-stable.nixosModules.home-manager
      # ./acme.nix
      ./auto-upgrade.nix
      ./fish.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      # ./optin-persistence.nix
      # ./sops.nix
      # ./ssh-serve-store.nix
      # ./steam-hardware.nix
      # ./systemd-initrd.nix
      # ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?
  # environment.profileRelativeSessionVariables = {
  #   QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  # };

  hardware.enableRedistributableFirmware = true;
  # networking.domain = "fri";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  security = {
    # pam.services.sudo.u2fAuth = true;
    # sudo = {
    #   enable = true;
    #   wheelNeedsPassword = false;
    # };
    sudo-rs = {
      enable = true;
      # execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  services.dbus.implementation = "broker";
  # environment.etc."tmpfiles.d/tmp.conf".text = ''
  #   d /tmp 1777 root root 3d
  #   d /var/tmp 1777 root root 3d
  # '';
}
