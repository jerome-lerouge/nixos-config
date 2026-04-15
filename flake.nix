{
  description = "NixOS flake for my old MacBookPro 12.1 Early 2015";

  inputs = {
    # NixOS official package source, unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager, used for managing user configuration
    # Documentation for unstable https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Claud Cowork for Nnixos
    #claude-for-linux = {
    #  url = "github:heytcass/claude-for-linux";
    #};

    # NFL form Neovim
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    #claude-for-linux,
    nvf,
    ...
  } @ inputs: {
    # My hostname "nixosmac"
    nixosConfigurations.nixosmac = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Test overlays.
      # nixpkgs.overlays = [./overlays/claude-code.nix];

      modules = [
        # Import the previous configuration.nix
        ./configuration.nix

        # My Macbook from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.apple-macbook-pro-12-1

        # Make home-manager as a module of Nixos
        # so that home-manager configuration will be deployed automatically we executing 'nixos-rebuild switch'
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          # Use my username
          #home-manager.users.jerome = import ./home.nix;

          home-manager.users.jerome = {
            imports = [
              ./home.nix
              # Import the home-manager module that provides the options
              #claude-for-linux.homeManagerModules.default
              nvf.homeManagerModules.default
            ];
          };

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  };
}
