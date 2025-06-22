{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
        ssbm.url = "github:djanatyn/ssbm-nix";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
      inherit (self) outputs;
    in {
        ssbm.slippi-launcher= {
          enable = true;
        };

        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              home-manager.backupFileExtension = "bak";
              home-manager.users.andre.imports = [
                  ./home/home.nix
              ];
            }
          ];
        };
      };
}
