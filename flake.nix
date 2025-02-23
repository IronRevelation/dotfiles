{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";

    # use the following for unstable:
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
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
      nixpkgs-unstable,
      home-manager,
      ghostty,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlay-unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${system};
      };
      nixpkgsWithOverlays = {
        nixpkgs = {
          overlays = [ overlay-unstable ];
        };
      };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            nixpkgsWithOverlays
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
