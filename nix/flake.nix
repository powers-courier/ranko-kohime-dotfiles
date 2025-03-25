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
        n100-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          networking.hostName = n100-1;
          modules = [
            ./hosts/n100-1-hardware.nix
            ./modules/bootloader-default.nix
            ./modules/flake-enabler.nix
            ./modules/locale.nix
            ./modules/zram.nix
            ./users/ranko.nix
          ];
        };
        n200-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/n200-1-hardware.nix
            ./modules/bootloader-default.nix
            ./modules/flake-enabler.nix
            ./modules/locale.nix
            ./modules/zram.nix
            ./users/ranko.nix
          ];
        };
        n200-2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/n200-2-hardware.nix
            ./modules/bootloader-default.nix
            ./modules/flake-enabler.nix
            ./modules/locale.nix
            ./modules/zram.nix
            ./users/ranko.nix
          ];
        };
        n200-3 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/n200-3-hardware.nix
            ./modules/bootloader-default.nix
            ./modules/flake-enabler.nix
            ./modules/locale.nix
            ./modules/zram.nix
            ./users/ranko.nix
          ];
        };
        postgres-vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/postgres-hardware.nix
            ./hosts/postgres-vm.nix
            ./modules/bootloader-default.nix
            ./modules/locale.nix
            ./modules/zram.nix
            ./users/ranko.nix
          ];
        };
      };
    };
}
