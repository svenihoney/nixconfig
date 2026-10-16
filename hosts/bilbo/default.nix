{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    # inputs.hardware.nixosModules.common-gpu-nvidia
    # inputs.hardware.nixosModules.common-gpu-nvidia-disable

    # inputs.stylix-stable.nixosModules.stylix
    # inputs.home-manager.nixosModules.home-manager
    # inputs.home-manager-stable.nixosModules.home-manager

    ./hardware-configuration.nix

    ../common/global
    ../net-customer1/host/users/fischer

    # ../common/optional/gamemode.nix
    # ../common/optional/wireless.nix
    # ../common/optional/ckb-next.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/desktop.nix
    # ../common/optional/quietboot.nix
    # ../common/optional/lol-acfix.nix
    # ../common/optional/starcitizen-fixes.nix
    ../common/optional/podman.nix
    ../common/optional/virtualisation.nix
    # ../common/optional/warpinator.nix
    # ../common/optional/printing.nix
    ../common/optional/networking.nix
    # ../common/optional/nfs.nix
    ../common/optional/stylix.nix
    ../common/optional/bluetooth.nix
    ../common/optional/backlight.nix
  ];

  networking = {
    hostName = "bilbo";
    networkmanager.enable = true;
    # proxy = {
    #   default = "http://proxy:8888";
    #   noProxy = "127.0.0.1,localhost,.software.ads";
    # };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  security.pki.certificateFiles = [./ucs-root-ca.crt];

  boot = {
    loader = {
      # systemd-boot = {
      #   enable = !config.boot.lanzaboote.enable;
      #   configurationLimit = 3;
      # };
      limine = {
        enable = true;
        secureBoot.enable = true;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    # binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
    # supportedFilesystems = ["zfs"];
    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/var/lib/sbctl";
    # };
    # blacklistedKernelModules = ["nouveau"];
  };

  # Auto login me
  services.greetd.settings.initial_session = {
    # Change "Hyprland" to the command to run your window manager. ^Note1
    # command = "${lib.getExe pkgs.uwsm} start -F ${lib.getExe pkgs.hyprland}";
    command = "${lib.getExe pkgs.uwsm} start -e -D Hyprland hyprland.desktop";
    # Change "${user}" to your username or to your username variable.
    user = "fischer";
  };

  programs = {
    # light.enable = true;
    # adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };
  services.gvfs.enable = true;

  hardware = {
    graphics = {
      enable = true;
    };
    # amdgpu.amdvlk = true;
    nvidia.open = true;
    bluetooth.powerOnBoot = false;
  };

  services = {
    # Lid settings
    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
    };
    fprintd.enable = true;

    # Usevia access to hidraw device
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="FC32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    udisks2.enable = true;
    fwupd.enable = true;
  };

  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };
  services.upower.enable = true;

  services.nfs.server = {
    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = ''
      /srv/qnxexch 192.168.1.3(ro,nohide,insecure,no_subtree_check,root_squash) 192.168.1.55(ro,nohide,insecure,no_subtree_check,root_squash)
      /srv/lnxexch 192.168.1.55(rw,nohide,insecure,no_subtree_check,root_squash)
    '';
  };
  networking.firewall = {
    enable = true;
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [111 2049 4000 4001 4002 20048];
    allowedUDPPorts = [111 2049 4000 4001 4002 20048];
  };
  nix = {
    settings = {
      substituters = lib.mkBefore [
        "https://nix-cache.software.ads/nixos-images"
      ];
      trusted-public-keys = lib.mkBefore [
        "nixos-images:wTU650Sa2OxMeyU/ERWGmAiGC/dGCGBdO3ZlN9zoB8Q="
      ];
    };
  };

  stylix.targets.kmscon.enable = false; # Workaround for 26.05 -> .11 change issue

  system.stateVersion = "23.11";
}
