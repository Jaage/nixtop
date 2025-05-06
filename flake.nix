{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nil.url = "github:oxalica/nil";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
#    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.ua = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.chaotic.nixosModules.default

#        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
