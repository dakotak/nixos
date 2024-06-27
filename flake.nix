{
    description = "Dakotak's Nix Configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ...} @ inputs:
    let
        inherit (self) outputs;
        inherit (nixpkgs) lib;
        specialArgs = { inherit inputs outputs nixpkgs; };
    in
    {
        nixosConfigurations = {
            xone = lib.nixosSystem {
                inherit specialArgs;
                system = "x86_64-linux";
                modules = [
                    home-manager.nixosModules.home-manager{
                        home-manager.extraSpecialArgs = specialArgs;
                    }
                    ./hosts/xone
                ];
            };
        };
    };
}
