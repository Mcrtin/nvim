{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        fullModule = {
          inherit pkgs;
          module = import ./config/full.nix;
        };
        liteModule = {
          inherit pkgs;
          module = import ./config/lite.nix;
        };
        fullNvim = nixvim'.makeNixvimWithModule fullModule;
        liteNvim = nixvim'.makeNixvimWithModule liteModule;
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule fullModule;
          full = nixvimLib.check.mkTestDerivationFromNixvimModule fullModule;
          lite = nixvimLib.check.mkTestDerivationFromNixvimModule liteModule;
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = fullNvim;
          full = fullNvim;
          lite = liteNvim;
        };
      };
    };
}
