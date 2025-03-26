{
  description = "Ranko Kohime's Flake, now with 100% more ZFS!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      home-manager,
      flake-utils,
      hardware,
      ...
    }:

  let
    vars = {
      loKale = "en_US.UTF-8";
      timeZern = "Etc/UTC";
      truenas-ip = "192.168.0.2";
    };
  in
    {
      nixosConfigurations = {
        jelly-proxy-01 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ({ config, pkgs, ... }: {
              networking.hostName = "jelly-proxy-01";
              system.stateVersion = "25.05";
            })
            ./hosts/jelly-proxy-01-hardware.nix
            ./modules/default-modules.nix
            ./modules/remote-proxy-nodes.nix
            ./modules/tailscale.nix
          ];
        };
        n100-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ({ config, pkgs, ... }: {
              networking.hostName = "n100-1";
              system.stateVersion = "23.11";
            })
            ./hosts/n100-1-hardware.nix
            ./modules/default-modules.nix
            ./modules/tailscale.nix
          ];
        };
        n200-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ({ config, pkgs, ... }: {
              networking.hostName = "n200-1";
              system.stateVersion = "24.05";
            })
            ./hosts/n200-1-hardware.nix
            ./modules/default-modules.nix
            ./modules/tailscale.nix
          ];
        };
        n200-2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ({ config, pkgs, ... }: {
              networking.hostName = "n200-2";
              system.stateVersion = "24.05";
            })
            ./hosts/n200-2-hardware.nix
            ./modules/default-modules.nix
            ./modules/tailscale.nix
          ];
        };
        n200-3 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ({ config, pkgs, ... }: {
              networking.hostName = "n200-3";
              system.stateVersion = "24.05";
            })
            ./hosts/n200-3-hardware.nix
            ./modules/default-modules.nix
            ./modules/tailscale.nix
          ];
        };
        postgres-vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/postgres-hardware.nix
            ./hosts/postgres-vm.nix
            ./modules/default-modules.nix
          ];
        };
      };
    };
}
