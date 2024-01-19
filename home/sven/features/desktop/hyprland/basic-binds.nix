{lib, ...}: let
  workspaces = map toString (lib.range 0 9);
  # ++ (map (n: "F${toString n}") (lib.range 1 12));
  # Map keys to hyprland directions
  directions = rec {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    h = left;
    l = right;
    k = up;
    j = down;
  };
in {
  wayland.windowManager.hyprland.settings = {
    bindm = ["SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow"];

    bind =
      [
        "SUPER SHIFT, Q, killactive,"
        "SUPER, M, exit,"
        "SUPER SHIFT, Space, togglefloating"
        "SUPER SHIFT, Space, movetoworkspace, m+0"

        # "SUPER,s,togglesplit"
        "SUPER,f,fullscreen,1"
        "SUPER SHIFT,f,fullscreen,0"
        # "SUPERSHIFT,space,togglefloating"

        "SUPER,g,togglegroup"
        "SUPER,t,lockactivegroup,toggle"
        "SUPER,v,changegroupactive,f"
        "SUPER SHIFT,V,changegroupactive,b"

        # "SUPER, P, pseudo, # dwindle"
        # "SUPER, J, togglesplit, # dwindle"

        "SUPER SHIFT, Minus, movetoworkspace, special"
        "SUPER, Minus, togglespecialworkspace,"
      ]
      ++
      # Change workspace
      (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "SUPER SHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList
        (key: direction: "SUPER,${key},movefocus,${direction}")
        directions)
      ++
      # Swap windows
      (lib.mapAttrsToList
        (key: direction: "SUPERSHIFT,${key},swapwindow,${direction}")
        directions)
      ++
      # Move windows
      (lib.mapAttrsToList
        (key: direction: "SUPERCONTROL,${key},movewindoworgroup,${direction}")
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList
        (key: direction: "SUPERALT,${key},focusmonitor,${direction}")
        directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (key: direction: "SUPERCTRLSHIFT,${key},movecurrentworkspacetomonitor,${direction}")
        directions);

    binde = [
      "SUPER,p,splitratio,-0.25"
      "SUPER SHIFT,P,splitratio,-0.3333333"

      "SUPER,w,splitratio,0.25"
      "SUPER SHIFT,W,splitratio,0.3333333"
    ];
  };
}
