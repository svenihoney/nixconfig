{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    lens
  ];

  programs = {
    k9s = {
      enable = true;
      hotkey = {
        # Make sure this is camel case
        hotKeys = {
          shift-0 = {
            shortCut = "Shift-0";
            description = "Viewing pods";
            command = "pods";
          };
        };
      };
    };
  };
}
