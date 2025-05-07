{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nil.url = "github:oxalica/nil";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    #    zig-overlay.url = "github:mitchellh/zig-overlay";
    #    zls.url = "github:zigtools/zls";
#    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    #    zig-overlay,
    #    zls,
    ...
  } @ inputs: {
    nixosConfigurations.ua = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.allmight = ./home.nix;
        }
        inputs.chaotic.nixosModules.default
#        inputs.stylix.nixosModules.stylix
          # zig-overlay.packages.x86_64-linux.master
          #        inputs.zls.packages.x86_64-linux
      ];
    };
  };
}
