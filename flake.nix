{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nil.url = "github:oxalica/nil";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls";
#    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    zig-overlay,
    zls,
    ...
  } @ inputs: {
    nixosConfigurations.ua = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.chaotic.nixosModules.default
#        inputs.stylix.nixosModules.stylix
          # zig-overlay.packages.x86_64-linux.master
          #        inputs.zls.packages.x86_64-linux
      ];
    };
  };
}
