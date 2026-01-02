{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    noctalia = {
        url = "github:noctalia-dev/noctalia-shell";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./modules/gaming.nix
        ./modules/noctalia.nix
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
