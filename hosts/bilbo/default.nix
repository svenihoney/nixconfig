{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-laptop

    # inputs.stylix-stable.nixosModules.stylix
    # inputs.home-manager.nixosModules.home-manager
    # inputs.home-manager-stable.nixosModules.home-manager

    ./hardware-configuration.nix

    ../common/global
    ../common/users/fischer

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
  ];

  networking = {
    hostName = "bilbo";
    networkmanager.enable = true;
    proxy = {
      default = "http://proxy:8888";
      noProxy = "127.0.0.1,localhost,.software.ads";
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  security.pki.certificateFiles = [./ucs-root-ca.crt];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
      timeout = 1;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  programs = {
    light.enable = true;
    # adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };
  services.gvfs.enable = true;

  hardware = {
    opengl = {
      enable = true;
    };
    # amdgpu.amdvlk = true;
  };

  services = {
    # Lid settings
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
    fprintd.enable = true;

    # Usevia access to hidraw device
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="FC32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    udisks2.enable = true;
    fwupd.enable = true;
  };

  # services.btrbk = {
  #   instances.local = {
  #     onCalendar = "hourly";
  #     settings = {
  #       # ssh_identity = "/etc/btrbk_key"; # NOTE: must be readable by user/group btrbk
  #       # ssh_user = "btrbk";
  #       stream_compress = "lz4";
  #
  #       timestamp_format = "long";
  #       snapshot_preserve_min = "8h";
  #       snapshot_preserve = "48h";
  #
  #       volume."/" = {
  #         # target = "ssh://myhost/mnt/mybackups";
  #         subvolume = {
  #           home = {};
  #           "home/sven/virtualmachines" = {};
  #         };
  #         snapshot_dir = "/.snapshots";
  #       };
  #     };
  #   };
  # };

  services.nfs.server = {
    enable = true;
    exports = ''
      /srv/qnxexch *(rw,sync,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
  };
  networking.firewall = {
    allowedTCPPorts = [111 1018 1019 1020 2039 4000 4001 4002 20048];
    allowedUDPPorts = [111 1018 1019 1020 2039 4000 4001 4002 20048];
  };
  system.stateVersion = "23.11";
}
