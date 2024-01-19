{
  description = "My NixOS configuration";

  # nixConfig = {
  #   extra-substituters = [ "https://cache.m7.rs" ];
  #   extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
  # };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    hardware.url = "github:nixos/nixos-hardware";
    # impermanence.url = "github:nix-community/impermanence";
    # nix-colors.url = "github:misterio77/nix-colors";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixgl.url = "github:guibou/nixGL";

    nh = {
      url = "github:viperml/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # utils.follows = "flake-utils";
        # flake-compat.follows = "flake-compat";
      };
    };
    stylix.url = "github:danth/stylix";
    # hyprland = {
    #   url = "github:hyprwm/hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # hyprwm-contrib = {
    #   url = "github:hyprwm/contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # firefox-addons = {
    #   url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # flake-utils.url = "github:numtide/flake-utils";

    # disconic.url = "github:misterio77/disconic";
    # website.url = "github:misterio77/website";
    # paste-misterio-me.url = "github:misterio77/paste.misterio.me";
    # yrmos.url = "github:misterio77/yrmos";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    home-manager-stable,
    # flake-utils,
    deploy-rs,
    pre-commit-hooks,
    nixgl,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    # lib = nixpkgs-stable.lib // home-manager-stable.lib;
    # systems = ["x86_64-linux" "aarch64-linux"];
    systems = ["x86_64-linux"];
    forEachSystem = lib.genAttrs systems;
    genNixosConfig = hostName: {
      user,
      hostPlatform,
      stable,
      ...
    }:
      if stable
      then
        nixpkgs-stable.lib.nixosSystem
        {
          # pkgs = self.stable-pkgs.${hostPlatform};
          modules = [./hosts/${hostName}];
          specialArgs = {inherit inputs outputs;};
        }
      else
        nixpkgs.lib.nixosSystem {
          # pkgs = self.unstable-pkgs.${hostPlatform};
          modules = [./hosts/${hostName}];
          specialArgs = {inherit inputs outputs;};
        };
    genHomeConfig = hostName: {
      user,
      hostPlatform,
      stable,
      ...
    }:
      if stable
      then
        home-manager-stable.lib.homeManagerConfiguration
        {
          modules = [
            ./home/${user}/${hostName}.nix
          ];
          pkgs = self.stable-pkgs.${hostPlatform};
          extraSpecialArgs = {inherit inputs outputs;};
        }
      else
        home-manager.lib.homeManagerConfiguration {
          modules = [
            ./home/${user}/${hostName}.nix
          ];
          pkgs = self.unstable-pkgs.${hostPlatform};
          extraSpecialArgs = {inherit inputs outputs;};
        };
  in {
    inherit lib;
    stable-pkgs = forEachSystem (system:
      import nixpkgs-stable {
        inherit system;
        overlays = [nixgl.overlay];
        config.allowUnfree = true;
        config.allowAliases = true;
      });
    unstable-pkgs = forEachSystem (system:
      import nixpkgs {
        inherit system;
        overlays = [nixgl.overlay];
        config.allowUnfree = true;
        config.allowAliases = true;
      });

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # templates = import ./templates;

    # overlays = import ./overlays { inherit inputs outputs; };
    # hydraJobs = import ./hydra.nix { inherit inputs outputs; };

    # packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
    devShells = forEachSystem (import ./shell.nix inputs);

    formatter = forEachSystem (pkgs: pkgs.alejandro);
    checks = forEachSystem (import ./checks.nix inputs);
    # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    deploy = import ./deploy.nix inputs;
    # wallpapers = import ./home/sven/wallpapers;
    hosts = import ./hosts.nix;

    nixosConfigurations =
      lib.mapAttrs genNixosConfig (self.hosts.nixos or {});
    homeConfigurations =
      lib.mapAttrs genHomeConfig (self.hosts.homeManager or {});
  };
}
