{ config
, lib
, pkgs
, ...
}: {
  services.network-manager-applet.enable = true;

  # home.packages = with pkgs; [wireguard-tools vpnc];
}
