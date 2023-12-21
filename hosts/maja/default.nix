{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.stylix.nixosModules.stylix

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
    ../common/optional/nfs.nix
    ../common/optional/stylix.nix
  ];

  networking = {
    hostName = "maja";
    useDHCP = false;
    bridges = {
      br0 = {
        interfaces = [ "enp6s0" ];
      };
    };
    interfaces.br0 = {
      useDHCP = true;
    };
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
    adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };
  services.gvfs.enable = true;

  hardware = {
    opengl = {
      enable = true;
    };
    amdgpu.amdvlk = true;
  };

  # Usevia access to hidraw device
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fc32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  services.udisks2.enable = true;
  services.fwupd.enable = true;

  services.btrbk = {
    instances.local = {
      onCalendar = "hourly";
      settings = {
        # ssh_identity = "/etc/btrbk_key"; # NOTE: must be readable by user/group btrbk
        # ssh_user = "btrbk";
        stream_compress = "lz4";

        timestamp_format = "long";
        snapshot_preserve_min = "8h";
        snapshot_preserve = "48h";

        volume."/" = {
          # target = "ssh://myhost/mnt/mybackups";
          subvolume = {
            home = { };
            "home/sven/virtualmachines" = { };
          };
          snapshot_dir = "/.snapshots";
        };
      };
    };
  };

  system.stateVersion = "23.11";
}
