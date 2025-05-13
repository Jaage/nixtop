{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:Jaage/nixvim";
    # stylix.url = "github:danth/stylix";
    # zig-overlay.url = "github:mitchellh/zig-overlay";
    # zls.url = "github:zigtools/zls";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    # zig-overlay,
    # zls,
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
          home-manager.backupFileExtension = "backup";
        }
        inputs.chaotic.nixosModules.default
        # inputs.stylix.nixosModules.stylix
        # zig-overlay.packages.x86_64-linux.master
        # inputs.zls.packages.x86_64-linux
      ];
    };
  };
}
