{
  description = "My NixOS configuration";

  # nixConfig = {
  #   extra-substituters = [ "https://cache.m7.rs" ];
  #   extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
  # };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-trunk.url = "github:nixos/nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    # impermanence.url = "github:nix-community/impermanence";
    # nix-colors.url = "github:misterio77/nix-colors";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix-stable = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    # nixgl.url = "github:guibou/nixGL";

    # nh = {
    #   url = "github:viperml/nh";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # utils.follows = "flake-utils";
        # flake-compat.follows = "flake-compat";
      };
    };
    stylix.url = "github:danth/stylix";
    stylix-stable.url = "github:danth/stylix/release-24.05";
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
    nur.url = "github:nix-community/nur";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    anyrun.url = "github:fufexan/anyrun/launch-prefix";

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nixvim-stable = {
    #   url = "github:nix-community/nixvim/nixos-24.11";
    #   inputs.nixpkgs.follows = "nixpkgs-stable";
    # };
    # flake-utils.url = "github:numtide/flake-utils";

    flake-parts.url = "github:hercules-ci/flake-parts";

    # disconic.url = "github:misterio77/disconic";
    # website.url = "github:misterio77/website";
    # paste-misterio-me.url = "github:misterio77/paste.misterio.me";
    # yrmos.url = "github:misterio77/yrmos";

    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # hyprpaper = {
    #   url = "github:hyprwm/hyprpaper";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Emacs
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      # Optional, to download less. Neither the module nor the overlay uses this input.
      inputs.nixpkgs.follows = "";
    };

    # Currently broken
    quickshell = {
      # url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
    };
    # svenivim = {
    #   url = "git+https://git.effeffcee.de/sven/nixvim.git";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    # nixpkgs-trunk,
    home-manager,
    home-manager-stable,
    # flake-utils,
    flake-parts,
    deploy-rs,
    pre-commit-hooks,
    # nixgl,
    nixvim,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # lib = nixpkgs.lib // home-manager.lib;
    # lib = nixpkgs-stable.lib // home-manager-stable.lib;
    # systems = ["x86_64-linux" "aarch64-linux"];
    systems = ["x86_64-linux"];
    # trunkOverlay = final: prev: {trunk = nixpkgs-trunk.legacyPackages.${prev.system};};
    forEachSystem = nixpkgs.lib.genAttrs systems;
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
          modules = [
            # trunkOverlay
            inputs.stylix-stable.nixosModules.stylix
            inputs.home-manager-stable.nixosModules.home-manager
            ./hosts/${hostName}
          ];
          specialArgs = {inherit inputs outputs;};
        }
      else
        nixpkgs.lib.nixosSystem {
          # pkgs = self.unstable-pkgs.${hostPlatform};
          modules = [
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            ./hosts/${hostName}
          ];
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
            inputs.stylix-stable.homeManagerModules.stylix
            ./home/${user}/${hostName}.nix
          ];
          pkgs = self.stable-pkgs.${hostPlatform};
          extraSpecialArgs = {inherit inputs outputs;};
        }
      else
        home-manager.lib.homeManagerConfiguration {
          modules = [
            inputs.stylix.homeManagerModules.stylix
            ./home/${user}/${hostName}.nix
          ];
          pkgs = self.unstable-pkgs.${hostPlatform};
          extraSpecialArgs = {inherit inputs outputs;};
        };
    nvim-flake = import ./home/sven/features/editors/nvim/flake.nix;
    nvim-outputs = nvim-flake.outputs {
      inherit self;
      inherit nixpkgs;
      inherit nixvim;
      inherit flake-parts;
    };
  in {
    # inherit lib;
    stable-pkgs = forEachSystem (system:
      import nixpkgs-stable {
        inherit system;

        overlays = [
          (final: prev: {
            python3 = prev.python3.override {
              packageOverrides = pfinal: pprev: {
                debugpy = pprev.debugpy.overrideAttrs (oldAttrs: {
                  pytestCheckPhase = "true";
                });
              };
            };
            python3Packages = final.python3.pkgs;
          })
        ];

        # overlays = [nixgl.overlay];
      });
    unstable-pkgs = forEachSystem (system:
      import nixpkgs {
        inherit system;
        # overlays = [nixgl.overlay self.overlays];
        # overlays = [inputs.firefox-addons.overlay];
        # overlays = [inputs.nur.overlay];
        #     pkgs = prev;
        # config.allowUnfree = true;
        #   }; })];
        # overlays = [nixgl.overlay];
      });

    nixosModules = import ./nix/modules/nixos;
    homeManagerModules = import ./nix/modules/home-manager;
    # templates = import ./templates;

    overlays = import ./nix/overlays {inherit inputs outputs;};
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
      nixpkgs.lib.mapAttrs genNixosConfig (self.hosts.nixos or {});
    homeConfigurations =
      nixpkgs.lib.mapAttrs genHomeConfig (self.hosts.homeManager or {});

    # packages = forEachSystem (?inherit nvim-outputs.packages.default);
  };
}
