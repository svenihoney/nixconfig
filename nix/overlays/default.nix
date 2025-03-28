{
  outputs,
  inputs,
}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs
      (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  nur = inputs.nur.overlays.default;
  # Adds my custom packages
  additions = final: prev:
    import ../pkgs {pkgs = final;};

  # // {
  #   formats = prev.formats // import ../pkgs/formats {pkgs = final;};
  #   vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {};
  # };

  # hyprpaper = inputs.hyprpaper.overlays.hyprpaper;

  # Modifies existing packages
  modifications = final: prev: {
    python311 = prev.python311.override {
      packageOverrides = pfinal: pprev: {
        debugpy = pprev.debugpy.overrideAttrs (oldAttrs: {
          pytestCheckPhase = "true";
        });
      };
    };
    python311Packages = final.python311.pkgs;

    # pytestCheckPhase = ''true'';

    #   vimPlugins =
    #     prev.vimPlugins
    #     // {
    #       vim-numbertoggle = addPatches prev.vimPlugins.vim-numbertoggle [./vim-numbertoggle-command-mode.patch];
    #     };

    #   passExtensions =
    #     prev.passExtensions
    #     // {
    #       # https://github.com/tadfisher/pass-otp/pull/173
    #       pass-otp = addPatches prev.passExtensions.pass-otp [./pass-otp-fix-completion.patch];
    #     };

    #   # https://github.com/mdellweg/pass_secret_service/pull/37
    #   pass-secret-service = addPatches prev.pass-secret-service [./pass-secret-service-native.diff];

    #   # https://github.com/NixOS/nix/issues/5567#issuecomment-1193259926
    #   # nix = addPatches prev.nix [ ./nix-make-installables-expr-context.patch ];

    #   xdg-utils-spawn-terminal = addPatches prev.xdg-utils [./xdg-open-spawn-terminal.diff];

    #   pfetch = prev.pfetch.overrideAttrs (oldAttrs: {
    #     version = "unstable-2021-12-10";
    #     src = final.fetchFromGitHub {
    #       owner = "dylanaraps";
    #       repo = "pfetch";
    #       rev = "a906ff89680c78cec9785f3ff49ca8b272a0f96b";
    #       sha256 = "sha256-9n5w93PnSxF53V12iRqLyj0hCrJ3jRibkw8VK3tFDvo=";
    #     };
    #     # Add term option, rename de to desktop, add scheme option
    #     patches = (oldAttrs.patches or []) ++ [./pfetch.patch];
    #   });

    #   # Sane default values and crash avoidance (https://github.com/k-vernooy/trekscii/pull/1)
    #   trekscii = addPatches prev.trekscii [./trekscii.patch];

    #   qutebrowser = prev.qutebrowser.overrideAttrs (oldAttrs: {
    #     patches = (oldAttrs.patches or []) ++ [./qutebrowser-tree-tabs.diff];
    #   });

    #   scgit = prev.cgit-pink.overrideAttrs (_: {
    #     pname = "scgit";
    #     version = "0.1";
    #     src = final.fetchFromSourcehut {
    #       owner = "~sven";
    #       repo = "scgit";
    #       rev = "2cd05c95827fb94740e876733dc6f7fe88340de2";
    #       sha256 = "sha256-95mRJ3ZCSkLHqehFQdwM2BY0h+YDhohwpnRiF6/lZtA=";
    #     };
    #   });
  };
}
