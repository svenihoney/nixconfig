{lib, ...}: let
  workspaces = map toString (lib.range 1 10);
  # ++ (map (n: "F${toString n}") (lib.range 1 12));
  # Map keys to hyprland directions
  directions = {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    # h = left;
    # l = right;
    # k = up;
    # j = down;
  };
in {
  wayland.windowManager.hyprland.settings = {

    bind =
      [
        # Mouse bindings
        {
          _args = [
            "SUPER + mouse:272"
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
          ];
        }
        {
          _args = [
            "SUPER + mouse:273"
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
          ];
        }
        # Close window / kill active
        {
          _args = [
            "SUPER + SHIFT + Q"
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        # Exit Hyprland
        {
          _args = [
            "SUPER + SHIFT + M"
            (lib.generators.mkLuaInline "hl.dsp.exit()")
          ];
        }
        # Toggle floating
        {
          _args = [
            "SUPER + SHIFT + Space"
            (lib.generators.mkLuaInline "hl.dsp.window.float({action = \"toggle\"})")
          ];
        }
        # Toggle split
        # {
        #   _args = [
        #     "SUPER + S"
        #     (lib.generators.mkLuaInline "hl.dsp.window.toggle_split()")
        #   ];
        # }
        # Toggle fullscreen
        {
          _args = [
            "SUPER + f"
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({action = \"toggle\"})")
          ];
        }
        # # Toggle group
        # {
        #   _args = [
        #     "SUPER + g"
        #     (lib.generators.mkLuaInline "hl.dsp.window.group({action = \"toggle\"})")
        #   ];
        # }
        # # Lock active group toggle
        # {
        #   _args = [
        #     "SUPER + t"
        #     (lib.generators.mkLuaInline "hl.dsp.window.group({action = \"lockToggle\"})")
        #   ];
        # }
        # # Change group active forward
        # {
        #   _args = [
        #     "SUPER + v"
        #     (lib.generators.mkLuaInline "hl.dsp.window.group({action = \"next\"})")
        #   ];
        # }
        # # Change group active backward
        # {
        #   _args = [
        #     "SUPER + SHIFT + V"
        #     (lib.generators.mkLuaInline "hl.dsp.window.group({action = \"prev\"})")
        #   ];
        # }
        # # Pseudo (dwindle)
        # {
        #   _args = [
        #     "SUPER + P"
        #     (lib.generators.mkLuaInline "hl.dsp.window.pseudo()")
        #   ];
        # }
        # # Toggle split (dwindle)
        # {
        #   _args = [
        #     "SUPER + J"
        #     (lib.generators.mkLuaInline "hl.dsp.window.toggle_split()")
        #   ];
        # }
        # Move window to special workspace
        {
          _args = [
            "SUPER + SHIFT + Minus"
            (lib.generators.mkLuaInline "hl.dsp.window.move({workspace = \"special\"})")
          ];
        }
        # Toggle special workspace
        {
          _args = [
            "SUPER + Minus"
            (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"special\"})")
          ];
        }
      ]
      ++
      # Focus workspace (1-10)
      (map (n: {
          _args = [
            "SUPER + ${
              if n == "10"
              then "0"
              else n
            }"
            (lib.generators.mkLuaInline "hl.dsp.focus({workspace = ${n}})")
          ];
        })
        workspaces)
      ++
      # Move window to workspace (1-10)
      (map (n: {
          _args = [
            "SUPER + SHIFT + ${
              if n == "10"
              then "0"
              else n
            }"
            (lib.generators.mkLuaInline "hl.dsp.window.move({workspace = ${n}})")
          ];
        })
        workspaces)
      #   # Move focus
      ++ (lib.mapAttrsToList
        (key: direction: {
          _args = [
            "SUPER + ${key}"
            (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"${direction}\"})")
          ];
        })
        directions)
      # Swap windows
      ++ (lib.mapAttrsToList
        (key: direction: {
          _args = [
            "SUPER + SHIFT + ${key}"
            (lib.generators.mkLuaInline "hl.dsp.window.swap({direction = \"${direction}\"})")
          ];
        })
        directions)
      # Move windows
      ++ (lib.mapAttrsToList
        (key: direction: {
          _args = [
            "SUPER + CONTROL + ${key}"
            (lib.generators.mkLuaInline "hl.dsp.window.move({direction = \"${direction}\"})")
          ];
        })
        directions)
      # Focus monitor
      ++ (lib.mapAttrsToList
        (key: direction: {
          _args = [
            "SUPER + ALT + ${key}"
            (lib.generators.mkLuaInline "hl.dsp.focus({monitor = \"${direction}\"})")
          ];
        })
        directions)
      # Move workspace to monitor
      ++ (lib.mapAttrsToList
        (key: direction: {
          _args = [
            "SUPER + CONTROL + SHIFT + ${key}"
            (lib.generators.mkLuaInline "hl.dsp.workspace.move({monitor = \"${direction}\"})")
          ];
        })
        directions);

    # binde = [
    #   # Split ratio decrease
    #   {
    #     _args = [
    #       "SUPER + P"
    #       (lib.generators.mkLuaInline "hl.dsp.window.resize({delta = -0.25})")
    #     ];
    #   }
    #   {
    #     _args = [
    #       "SUPER + SHIFT + P"
    #       (lib.generators.mkLuaInline "hl.dsp.window.resize({delta = -0.3333333})")
    #     ];
    #   }
    #   # Split ratio increase
    #   {
    #     _args = [
    #       "SUPER + W"
    #       (lib.generators.mkLuaInline "hl.dsp.window.resize({delta = 0.25})")
    #     ];
    #   }
    #   {
    #     _args = [
    #       "SUPER + SHIFT + W"
    #       (lib.generators.mkLuaInline "hl.dsp.window.resize({delta = 0.3333333})")
    #     ];
    #   }
    # ];
  };
}
