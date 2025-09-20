{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix

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
  ];

  networking = {
    hostName = "puck";
    networkmanager.enable = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = false;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
      timeout = 1;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Auto login me
  services.greetd.settings.initial_session = {
    # Change "Hyprland" to the command to run your window manager. ^Note1
    command = "${lib.getExe pkgs.uwsm} start -F ${lib.getExe pkgs.hyprland}";
    # Change "${user}" to your username or to your username variable.
    user = "sven";
  };

  environment.etc.crypttab.text = ''
    data UUID=c2bb0cf5-0d1a-4be1-a037-8643732fab89 /root/datakeyfile.key
  '';

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
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
    amdgpu.amdvlk.enable = true;
    # amdgpu.opencl.enable = false;
  };

  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
  };

  # Usevia access to hidraw device
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="FC32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2717", ATTRS{idProduct}=="d001", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  services.udisks2.enable = true;
  services.fwupd.enable = true;

  # Firewall for syncthing
  networking.firewall = {
    allowedTCPPorts = [22000];
    allowedUDPPorts = [22000 21027];
  };

  system.stateVersion = "23.11";
}
