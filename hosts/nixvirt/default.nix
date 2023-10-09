{ pkgs, inputs, ... }: {
  imports = [

    ./hardware-configuration.nix

    ../common/global
    ../common/users/sven

    # ../common/optional/pantheon.nix
    # ../common/optional/quietboot.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = false;

  networking = {
    hostName = "nixvirt";
    useDHCP = true;
    # interfaces.enp2s0 = {
    #   useDHCP = true;
    #   wakeOnLan.enable = true;

    #   ipv4 = {
    #     addresses = [{
    #       address = "192.168.0.13";
    #       prefixLength = 24;
    #     }];
    #   };
    #   ipv6 = {
    #     addresses = [{
    #       address = "2804:14d:8084:a484::3";
    #       prefixLength = 64;
    #     }];
    #   };
    # };
  };

  environment.sessionVariables = rec {
    # No QXL mesa driver: Allow software rendering
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  security.polkit.enable = true;

  # i18n.defaultLocale = "pt_BR.UTF-8";

  # environment.etc."sysconfig/lm_sensors".text = ''
  #   HWMON_MODULES="coretemp"
  # '';

  # hardware = {
  #   nvidia = {
  #     prime.offload.enable = false;
  #     modesetting.enable = true;
  #   };
  #   opengl = {
  #     enable = true;
  #     driSupport = true;
  #     driSupport32Bit = true;
  #   };
  # };

  system.stateVersion = "22.05";
}
