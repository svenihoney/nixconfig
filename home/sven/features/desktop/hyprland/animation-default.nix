{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    curve = [
      {
        _args = [
          "easein"
          {
            type = "bezier";
            points = [[0.11 0] [0.5 0]];
          }
        ];
      }
      {
        _args = [
          "easeout"
          {
            type = "bezier";
            points = [[0.5 1] [0.89 1]];
          }
        ];
      }
      {
        _args = [
          "easeinback"
          {
            type = "bezier";
            points = [[0.36 0] [0.66 (-0.56)]];
          }
        ];
      }
      {
        _args = [
          "easeoutback"
          {
            type = "bezier";
            points = [[0.34 1.56] [0.64 1]];
          }
        ];
      }
    ];

    animation = [
      {
        _args = [
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 3;
            bezier = "easeoutback";
            style = "slide";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 3;
            bezier = "easeinback";
            style = "slide";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "windowsMove";
            enabled = true;
            speed = 1;
            bezier = "easeoutback";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "workspaces";
            enabled = true;
            speed = 1;
            bezier = "easeoutback";
            style = "slide";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "fadeIn";
            enabled = true;
            speed = 3;
            bezier = "easeout";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "fadeOut";
            enabled = true;
            speed = 3;
            bezier = "easein";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "fadeSwitch";
            enabled = true;
            speed = 3;
            bezier = "easeout";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "fadeShadow";
            enabled = true;
            speed = 3;
            bezier = "easeout";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "fadeDim";
            enabled = true;
            speed = 3;
            bezier = "easeout";
          }
        ];
      }
      {
        _args = [
          {
            leaf = "border";
            enabled = true;
            speed = 3;
            bezier = "easeout";
          }
        ];
      }
    ];
  };
}
