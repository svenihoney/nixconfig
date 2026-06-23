{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    ./disko.nix

    ../common/global
    ../common/users/sven

    # ../common/optional/gamemode.nix
    # ../common/optional/wireless.nix
    # ../common/optional/ckb-next.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/desktop.nix
    # ../common/optional/quietboot.nix
    # ../common/optional/lol-acfix.nix
    ../common/optional/podman.nix
    ../common/optional/virtualisation.nix
    ../common/optional/warpinator.nix
    ../common/optional/printing.nix
    #../common/optional/nfs.nix
    ../common/optional/stylix.nix
    ../common/optional/bluetooth.nix
    ../common/optional/backlight.nix
  ];

  hardware.facter.reportPath = ./facter.json;

  networking = {
    hostName = "willi";
    networkmanager.enable = true;
  };

  boot = {
    loader = {
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 3;
      # };
      limine = {
        enable = true;
        secureBoot.enable = true;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = 1;
    };
    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/var/lib/sbctl";
    # };
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelPackages = pkgs.linuxPackages_latest;
    # binfmt = {
    #   emulatedSystems = ["aarch64-linux"];
    #   preferStaticEmulators = true;
    # };
    # resumeDevice = "/dev/disk/by-uuid/6e52b611-7ab8-4cb5-867c-b5c0f5e7bda7";
  };

  # Auto login me
  services.greetd.settings.initial_session = {
    # Change "Hyprland" to the command to run your window manager. ^Note1
    command = "${lib.getExe pkgs.uwsm} start -F hyprland.desktop";
    # Change "${user}" to your username or to your username variable.
    user = "sven";
  };

  # environment.etc.crypttab.text = ''
  #   data UUID=c2bb0cf5-0d1a-4be1-a037-8643732fab89 /root/datakeyfile.key
  # '';

  powerManagement.powertop.enable = true;
  programs = {
    # adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };
  services.gvfs.enable = true;

  # Lid settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend";
  };

  hardware = {
    graphics.enable = true;
    # amdgpu.amdvlk.enable = true;
    # amdgpu.opencl.enable = false;
  };

  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
  };
  services.upower.enable = true;

  services.udisks2.enable = true;
  services.fwupd.enable = true;

  # Firewall for syncthing
  # networking.firewall = {
  #   allowedTCPPorts = [22000];
  #   allowedUDPPorts = [22000 21027];
  # };

  # stylix.targets.kmscon.enable = false; # Workaround for 26.05 -> .11 change issue

  system.stateVersion = "25.11";
}
