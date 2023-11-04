{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.joplin-desktop
  ];
}
