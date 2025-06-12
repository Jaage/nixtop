{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:Jaage/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # stylix.url = "github:danth/stylix";
    # zig-overlay.url = "github:mitchellh/zig-overlay";
    # zig-overlay.inputs.nixpkgs.follows ="nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.ua = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          inputs.chaotic.nixosModules.default
          # inputs.stylix.nixosModules.stylix
        ];
      };
    };
}
