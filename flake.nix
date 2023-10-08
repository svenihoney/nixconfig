{
  description = "My NixOS configuration";

  # nixConfig = {
  #   extra-substituters = [ "https://cache.m7.rs" ];
  #   extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
  # };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    # impermanence.url = "github:nix-community/impermanence";
    # nix-colors.url = "github:misterio77/nix-colors";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    # disconic.url = "github:misterio77/disconic";
    # website.url = "github:misterio77/website";
    # paste-misterio-me.url = "github:misterio77/paste.misterio.me";
    # yrmos.url = "github:misterio77/yrmos";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      # templates = import ./templates;

      # overlays = import ./overlays { inherit inputs outputs; };
      # hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      # packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      deploy = import ./deploy.nix inputs;
      # wallpapers = import ./home/sven/wallpapers;
      hosts = import ./hosts.nix;

      nixosConfigurations = {
        # Main desktop
        # atlas =  lib.nixosSystem {
        #   modules = [ ./hosts/atlas ];
        #   specialArgs = { inherit inputs outputs; };
        # };
        # Secondary desktop
        nixvirt = lib.nixosSystem {
          modules = [ ./hosts/nixvirt ];
          specialArgs = { inherit inputs outputs; };
        };
        # Personal laptop
        # pleione = lib.nixosSystem {
        #   modules = [ ./hosts/pleione ];
        #   specialArgs = { inherit inputs outputs; };
        # };
      };

      homeConfigurations = {
        # Desktops
        # "sven@maja" = lib.homeManagerConfiguration {
        #   modules = [ ./home/sven/maja.nix ];
        #   pkgs = pkgsFor.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
        "sven@nixvirt" = lib.homeManagerConfiguration {
          modules = [ ./home/sven/nixvirt.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # "sven@willi" = lib.homeManagerConfiguration {
        #   modules = [ ./home/sven/willi.nix ];
        #   pkgs = pkgsFor.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
      };
    };
}
