{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
          home-manager.backupFileExtension = "bak";
          home-manager.users.andre.imports = [
            ./home/home.nix
          ];
        }

        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }

        ./nixos/configuration.nix
      ];
    };
  };
}
