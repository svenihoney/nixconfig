{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../desktop/common/wine.nix
  ];
  home.packages = with pkgs; [
    # lutris
    (pkgs.lutris.override {
      # Intercept buildFHSEnv to modify target packages
      buildFHSEnv =
        args:
        pkgs.buildFHSEnv (
          args
          // {
            multiPkgs =
              envPkgs:
              let
                # Fetch original package list
                originalPkgs = args.multiPkgs envPkgs;

                # Disable tests for openldap
                customLdap = envPkgs.openldap.overrideAttrs (_: {
                  doCheck = false;
                });
              in
              # Replace broken openldap with the custom one
              builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
          }
        );
    })
    # teamspeak_client
    # teamspeak5_client
  ];

  # home.persistence = {
  #   "/persist/home/${user}" = {
  #     allowOther = true;
  #     directories = [
  #       {
  #         # Use symlink, as games may be IO-heavy
  #         directory = "Games/Lutris";
  #         method = "symlink";
  #       }
  #       ".config/lutris"
  #       ".local/share/lutris"
  #     ];
  #   };
  # };
}
