{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.gnome-boxes
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///session" "qemu:///system"];
      uris = ["qemu:///session" "qemu:///system"];
    };
  };

  home.file.".config/libvirt/qemu.conf" = {
    text = ''
      nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
      namespaces = []
      bridge_helper = "/run/wrappers/bin/qemu-bridge-helper"
    '';
  };
}
