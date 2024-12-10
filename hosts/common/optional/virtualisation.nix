{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # x86 only
        runAsRoot = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
            .fd
          ];
        };
        swtpm = {
          enable = true;
          # package = pkgs.swtpm-tpm2;
        };
      };
      allowedBridges = ["virbr0" "br0"];
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
}
