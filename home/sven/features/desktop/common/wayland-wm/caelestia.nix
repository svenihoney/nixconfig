{
  config,
  inputs,
  lib,
  pkgs,
  ...
  # }: let
  #   package =
  #     inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli;
  # in {
  #   home.packages = [
  #     package
  #   ];
}: {
  # services.caelestia-shell = {
  #   enable = true;
  # };
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
    };
    # cli.enable = true;
  };
  wayland.windowManager.hyprland = let
    shell = "${lib.getExe config.programs.caelestia.package}";
  in {
    settings = {
      bind = [
        "SUPER ,d,exec,${shell} ipc call drawers toggle launcher"
        "SUPER ,n,exec,${shell} ipc call drawers toggle sidebar"
        "SUPER SHIFT,n,exec,${shell} ipc call notifs clear"
      ];
    };
  };
}
