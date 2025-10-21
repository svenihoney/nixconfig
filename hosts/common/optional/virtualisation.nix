{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # package = pkgs.qemu_kvm; # x86 only
        runAsRoot = true;
        swtpm = {
          enable = true;
          package = pkgs.swtpm;
        };
      };
      allowedBridges = ["virbr0" "br0"];
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
}
