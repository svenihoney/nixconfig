{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    inputs.home-manager.nixosModules.home-manager
    # inputs.stylix.nixosModules.stylix

    # inputs.nixos-cosmic.nixosModules.default

    ./hardware-configuration.nix

    ../common/global
    ../common/users/sven

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
    ../common/optional/nfs.nix
    ../common/optional/stylix.nix
  ];

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
      systemd-boot = {
        enable = false;
        configurationLimit = 3;
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
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };

  hardware = {
    graphics.enable = true;
    amdgpu.amdvlk.enable = true;
    amdgpu.opencl.enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  services = {
    gvfs.enable = true;
    udev = {
      # Usevia access to hidraw device
      extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fc32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2717", ATTRS{idProduct}=="d001", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
      packages = [pkgs.qmk-udev-rules];
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
              home = {};
              "home/sven/virtualmachines" = {};
            };
            snapshot_dir = "/.snapshots";
          };
          volume."/home/sven/kunden/vorwerk/image" = {
            # target = "ssh://myhost/mnt/mybackups";
            subvolume = {
              "." = {};
            };
            snapshot_dir = "/home/sven/kunden/vorwerk/image/.snapshots";
          };
        };
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      # syncthing
      22000
      # ollama
      11434
    ];
    allowedUDPPorts = [
      # syncthing
      22000
      21027
    ];
  };

  system.stateVersion = "23.11";
}
