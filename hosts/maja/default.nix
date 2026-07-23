{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    inputs.home-manager.nixosModules.home-manager

    inputs.musnix.nixosModules.musnix

    ./hardware-configuration.nix
    ./restic.nix

    ../common/global
    ../common/users/sven
    ../common/users/root

    # ../common/optional/gamemode.nix
    # ../common/optional/ckb-next.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/desktop.nix
    # ../common/optional/quietboot.nix
    # ../common/optional/lol-acfix.nix
    # ../common/optional/starcitizen-fixes.nix
    ../common/optional/podman.nix
    ../common/optional/virtualisation.nix
    ../common/optional/warpinator.nix
    ../common/optional/printing.nix
    ../common/optional/networking.nix
    # ../common/optional/nfs.nix
    ../common/optional/stylix.nix
  ];

  # TODO: Remove
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.zlib
      pkgs.openssl
    ];
  };

  # fonts.packages = with pkgs; [
  #   jetbrains-mono
  # ];
  # services.desktopManager.cosmic.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "maja";
    hostId = "44526795"; # head -c4 /dev/urandom | od -A none -t x4
    useDHCP = false;
    # bridges = {
    #   br0 = {
    #     interfaces = ["enp6s0"];
    #   };
    # };
    # interfaces.br0 = {
    #   useDHCP = true;
    # };
    #   wakeOnLan.enable = true;

    #   ipv4 = {
    #     addresses = [{
    #       address = "192.168.0.12";
    #       prefixLength = 24;
    #     }];
    #   };
    #   ipv6 = {
    #     addresses = [{
    #       address = "2804:14d:8084:a484::2";
    #       prefixLength = 64;
    #     }];
    #   };
    # };
    # interfaces.wlp5s0.useDHCP = false;
    # networkmanager.unmanaged = [ "interface-name:wlp5s0" ];
    # wireless.enable = false; # if you previously used wpa_supplicant
  };
  services.resolved = {
    enable = true;
    # dnssec = "true";
    # domains = [ "~." ];
    # fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    # dnsovertls = "true";
  };
  environment.etc.hosts.mode = "0644";

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
    # kernelPackages = pkgs.linuxPackages_cachyos-lto-znver4;

    # Enable hugepages for libvirt
    # kernelParams = [ "hugepagesz=2M" "hugepages=8192" ];  # 8192 × 2MB = 16GB

    binfmt = {
      emulatedSystems = [ "aarch64-linux" ];
      preferStaticEmulators = true;
    };
    resumeDevice = "/dev/disk/by-uuid/6e52b611-7ab8-4cb5-867c-b5c0f5e7bda7";
    # supportedFilesystems = ["zfs"];
    supportedFilesystems = [ "nfs" ];
    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/var/lib/sbctl";
    # };
  };
  musnix.enable = true;

  services.rpcbind.enable = lib.mkForce false;
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  programs = {
    # adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };

  hardware = {
    graphics.enable = true;
    amdgpu.opencl.enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "schedutil";
  };

  services = {
    gvfs.enable = true;
    udev = {
      # Usevia access to hidraw device
      extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fc32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2717", ATTRS{idProduct}=="d001", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
      packages = [ pkgs.qmk-udev-rules ];
    };
    udisks2.enable = true;
    fwupd.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    btrbk = {
      instances.local = {
        onCalendar = "hourly";
        settings = {
          # ssh_identity = "/etc/btrbk_key"; # NOTE: must be readable by user/group btrbk
          # ssh_user = "btrbk";
          stream_compress = "lz4";

          timestamp_format = "long";
          snapshot_preserve_min = "8h";
          snapshot_preserve = "8h 2d";

          volume."/" = {
            # target = "ssh://myhost/mnt/mybackups";
            subvolume = {
              home = { };
              "home/sven/virtualmachines" = { };
            };
            snapshot_dir = "/.snapshots";
          };
          volume."/home/sven/kunden/vorwerk/image" = {
            # target = "ssh://myhost/mnt/mybackups";
            subvolume = {
              "." = { };
            };
            snapshot_dir = "/home/sven/kunden/vorwerk/image/.snapshots";
          };
        };
      };
    };

    # kmscon = {
    #   enable = true;
    #   hwRender = true;
    #   useXkbConfig = true;
    # };
  };

  networking.firewall = {
    allowedTCPPorts = [
      # syncthing
      22000
      # ollama
      11434
    ];
    allowedUDPPorts = [
      # DHCP
      53
      67
      # syncthing
      22000
      21027
    ];
  };
  stylix.targets.kmscon.enable = false; # Workaround for 26.05 -> .11 change issue

  system.stateVersion = "23.11";
}
