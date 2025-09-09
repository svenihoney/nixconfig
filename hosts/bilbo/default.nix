{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
    # inputs.hardware.nixosModules.common-gpu-intel
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
    # proxy = {
    #   default = "http://proxy:8888";
    #   noProxy = "127.0.0.1,localhost,.software.ads";
    # };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  security.pki.certificateFiles = [./ucs-root-ca.crt];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    # binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  # Auto login me
  services.greetd.settings.initial_session = {
    # Change "Hyprland" to the command to run your window manager. ^Note1
    command = "${lib.getExe pkgs.uwsm} start -F ${lib.getExe pkgs.hyprland}";
    # Change "${user}" to your username or to your username variable.
    user = "fischer";
  };

  programs = {
    light.enable = true;
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
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = false;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
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

  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  services.nfs.server = {
    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = ''
      /srv/qnxexch 192.168.1.3(ro,nohide,insecure,no_subtree_check,root_squash)
    '';
  };
  networking.firewall = {
    enable = true;
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [111 2049 4000 4001 4002 20048];
    allowedUDPPorts = [111 2049 4000 4001 4002 20048];
  };

  system.stateVersion = "23.11";
}
