{
  description = "Ranko Kohime's Flake v2";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:openclaw/nix-openclaw";
    nix-openclaw.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
  nixpkgs,
  home-manager,
  nix-darwin,
  nix-openclaw,
  self,
  ...
  }@inputs:
    let
      inherit (nixpkgs) lib;
      platformModules = import ./lib/platformModules.nix { inherit lib; };
      mkHost = import ./lib/mkHost.nix { inherit inputs lib autoModules platformModules nixpkgs; };
      autoHardware = (import ./lib/autoHardware.nix {});
      autoLib = import ./lib/autoLib.nix { inherit inputs lib mkHost autoHardware; };
      inherit (autoLib)
        autoModules
        autoLinuxHosts
        autoDarwinHosts
        jellyProxyGenerator
      ;
      
      mkDarwin = { hostname, system ? "aarch64-darwin", extraModules ? [] }@args:
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs self; };
          modules = [
            (builtins.attrValues autoModules)
            { networking.hostName = hostname; }
          ] ++ extraModules;
        };
      home-manager-homeDir = ./home-manager/users;
      home-manager-userFiles = builtins.attrNames (
        nixpkgs.lib.filterAttrs (name: type:
          type == "regular" &&
          nixpkgs.lib.hasSuffix ".nix" name &&
          name != "default.nix"
        ) (builtins.readDir home-manager-homeDir)
      );
      home-manager-usernames = builtins.map (f: nixpkgs.lib.removeSuffix ".nix" f) home-manager-userFiles;
      mkHome = home-manager-username: home-manager.lib.homeManagerConfiguration {
      #  inherit pkgs;
        modules = [ (home-manager-homeDir + "/${home-manager-username}.nix") ];
      };
    in
    rec {
      darwinConfigurations = autoLib.autoDarwinHosts;
      homeConfigurations = nixpkgs.lib.genAttrs home-manager-usernames mkHome;
      #images = autoLib.Images;
      nixosConfigurations = autoLib.autoLinuxHosts //
        (autoLib.jellyProxyGenerator.jellyProxyGenerator or autoLib.jellyProxyGenerator or {});
    };
}
