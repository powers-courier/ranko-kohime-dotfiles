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
      fileServerIP = "192.168.0.2";
    };
  in
    {
      nixosConfigurations = {
        postgres-vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/postgres-hardware.nix
            ./hosts/postgres-vm.nix
          ];
        };
      };
    };
}
