{
  description = "Nikolay's Darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    nix-darwin,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        darwinConfigurations."nikolay-mac" = nix-darwin.lib.darwinSystem {
          modules = [./configuration.nix inputs.home-manager.darwinModules.default];
        };
      };
      systems = [
        "aarch64-darwin"
      ];
      perSystem = {config, ...}: {
      };
    };
}
