{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    #    inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
    inputs.hardware.nixosModules.common-gpu-intel
    #    inputs.hardware.nixosModules.common-pc-laptop

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
    # ../common/optional/virtualisation.nix
    # ../common/optional/warpinator.nix
    # ../common/optional/printing.nix
    # ../common/optional/networking.nix
    # ../common/optional/nfs.nix
    ../common/optional/stylix.nix
    # ../common/optional/bluetooth.nix
    ./proxy.nix
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  networking = {
    hostName = "dodo";
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
    # light.enable = true;
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
    # Usevia access to hidraw device
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="FC32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    udisks2.enable = true;
    fwupd.enable = true;
  };

  system.stateVersion = "23.11";
}
