{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.gnome.gnome-boxes
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///session" "qemu:///system"];
      uris = ["qemu:///session" "qemu:///system"];
    };
  };
}
