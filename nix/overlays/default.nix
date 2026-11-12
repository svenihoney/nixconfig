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
    # viddy = prev.viddy.overrideAttrs (old: {
    #   buildInputs = (old.buildInputs or [ ]) ++ [ prev.sqlite ];
    # });
  };
}
