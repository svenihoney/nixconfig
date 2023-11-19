{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      # runAsRoot = false;
      ovmf = {
        enable = true;
        packages = [pkgs.OVMFFull.fd];
      };
      swtpm = {
        enable = true;
        package = pkgs.swtpm-tpm2;
      };
    };
    allowedBridges = ["virbr0" "br0"];
  };
  programs.virt-manager.enable = true;
}
