{
  description = "Main flake";

  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-24.05";

    # use the following for unstable:
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    #nixvim.url = "github:IronRevelation/nixvim";

    # or any branch you want:
    # nixpkgs.url = "nixpkgs/{BRANCH-NAME}";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ghostty,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mattia = import ./home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit ghostty;
              };
            }
            inputs.stylix.nixosModules.stylix
          ];
        };
      };
    };
}
