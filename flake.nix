{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
      inherit (self) outputs;
    in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
                ./nixos/configuration.nix
                # inputs.home-manager.nixosModules.default
                # ./home/home.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs outputs; };
                    home-manager.users.andre.imports = [
                        ./home/home.nix
                    ];
                }
              ];
        };

        # homeConfigurations = {
        #   "andre@nixos" = home-manager.lib.homeManagerConfiguration {
        #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        #     extraSpecialArgs = {inherit inputs outputs;};
        #     modules = [./home/home.nix];
        # };
      };
    # };
}
