{
  description = "panavtec/NixOS configuration";

  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixos";
    };
    nvchad-starter = {
      url = "path:./config/nvchad";
      flake = false;
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixos";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
  };

  outputs =
    { nixos
    , nixos-unstable
    , nixos-hardware
    , home-manager
    , nur
    , nvchad4nix
    , ...
    }@attrs:
    let
      overlayNixOSUnstable = final: prev: {
        unstable = import nixos-unstable {
          system = prev.system;
          config.allowUnfree= true;
        };
      };
      overlayNvChad = final: prev: {
        nvchad = nvchad4nix.packages."${prev.system}".nvchad;
      };
      baseModules = [
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [ overlayNixOSUnstable overlayNvChad nur.overlays.default ];
        }
        nur.modules.nixos.default
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = false;
            users.panavtec = import ./nixos/home.nix;
            extraSpecialArgs = attrs;
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        # sudo nixos-rebuild --flake .#goku switch
        goku = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.channels = { inherit nixos nixos-unstable; };
          modules = baseModules ++ [
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            ./nixos/machines/goku/configuration.nix
          ];
        };
        # sudo nixos-rebuild --flake .#jiren switch
        jiren = nixos.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.channels = { inherit nixos nixos-unstable; };
          modules = baseModules ++ [
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-amd
            ./nixos/machines/jiren/configuration.nix
          ];
        };
      };
    };
}
