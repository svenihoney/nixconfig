{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    inputs.stylix.nixosModules.stylix

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
  ];

  networking = {
    hostName = "willi";
    networkmanager.enable = true;
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
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
    # kdeconnect.enable = true;
  };
  services.gvfs.enable = true;

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware = {
    opengl = {
      enable = true;
    };
    amdgpu.amdvlk = true;
    amdgpu.opencl = false;
  };

  # Usevia access to hidraw device
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="FC32", ATTRS{idProduct}=="0287", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  services.udisks2.enable = true;
  services.fwupd.enable = true;

  system.stateVersion = "23.11";
}
