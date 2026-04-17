{ config, lib, pkgs, ... }:

{
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "${lib.getExe pkgs.brightnessctl} +10%"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "${lib.getExe pkgs.brightnessctl} -10%"; }
    ];
  };

}
