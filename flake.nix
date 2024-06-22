{
  description = "panavtec/NixOS configuration";

  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixos";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    { nixos
    , nixos-unstable
    , nixos-hardware
    , home-manager
    , nur
    , ...
    }@attrs:
    let
      overlayNixOSUnstable = final: prev: {
        unstable = import nixos-unstable {
          system = prev.system;
          config.allowUnfree= true;
        };
      };
      baseModules = [
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [ overlayNixOSUnstable ];
        }
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;
          home-manager.users.panavtec = import ./nixos/home.nix;
          home-manager.extraSpecialArgs = attrs;
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
