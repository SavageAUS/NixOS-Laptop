{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./modules/gaming.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.shane = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}

