{
  description = "A very basic flake for a NixOS mac";
  
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    snowflake.url = "github:snowflakelinux/snowflake-modules";
    nix-data.url = "github:snowflakelinux/nix-data";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    snow.url = "github:snowflakelinux/snow";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."snowflakeos" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/hardware-configuration.nix
          ./nixos/configuration.nix
          ./nixos/snowflake.nix
          inputs.snowflake.nixosModules.snowflake
          inputs.nix-data.nixosModules.${system}.nix-data
        ];
        specialArgs = { inherit inputs; inherit system; };
    };
  };
    
  }
  
# sudo nixos-rebuild switch --flake .#myNixosMac
# nix flake update

