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

    # Mitigate ackege errors
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
              # Drop openldap (tests fail) and gtk2 (marked broken upstream; 32-bit gtk2
              # only matters for WINE games needing it)
              builtins.filter (p: !lib.elem (p.pname or "") [ "openldap" "gtk2" ]) originalPkgs
              ++ [ customLdap ];
          }
        );
    })
  ];

}
