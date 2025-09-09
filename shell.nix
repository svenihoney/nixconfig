{self, ...}: system:
with self.unstable-pkgs.${system}; {
  default = mkShell {
    name = "nix-config";

    nativeBuildInputs = [
      # Nix
      # agenix
      # cachix
      deploy-rs
      # nil
      nixd
      # nix-build-uncached
      # nix-eval-jobs
      # nixpkgs-fmt
      # statix

      # Lua
      # stylua
      # (luajit.withPackages (p: with p; [ luacheck ]))
      # lua-language-server

      # Shell
      shellcheck
      shfmt

      # GitHub Actions
      # act
      # actionlint
      # python3Packages.pyflakes
      # shellcheck

      # Misc
      # jq
      pre-commit
      # rage
      sops

      nh
    ];

    shellHook = ''
      ${self.checks.${system}.pre-commit-check.shellHook}
    '';
  };
}
