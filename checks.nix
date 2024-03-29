{
  self,
  deploy-rs,
  pre-commit-hooks,
  ...
}: system:
with self.pkgs.${system}; {
  pre-commit-check =
    pre-commit-hooks.lib.${system}.run
    {
      src = lib.cleanSource ../.;
      hooks = {
        # actionlint.enable = true;
        # luacheck.enable = true;
        alejandra = {
          enable = true;
          excludes = ["hardware-configuration.*.nix"];
        };
        shellcheck.enable = true;
        shfmt = {
          enable = true;
          # excludes = [ "users/bbigras/core/p10k-config/p10k.zsh" ];
        };
        # statix.enable = true;
        # stylua.enable = true;
      };
      # excludes = [
      #   "users/bbigras/core/p10k-config/p10k.zsh"
      # ];
    };
  # deployChecks = deploy-rs.lib.deployChecks;
}
# // (deploy-rs.lib.deployChecks self.deploy)
# // builtins.mapAttrs (deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib

