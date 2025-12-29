{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }: {
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
