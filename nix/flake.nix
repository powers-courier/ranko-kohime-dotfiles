{
  description = "Ranko Kohime's Flake, now with 100% more ZFS!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      hardware,
      disko,
      home-manager,
      flake-utils,
      ...
    }:

  let
    vars = {
      loKale = "en_US.UTF-8";
      timeZern = "Etc/UTC";
      tailscale-fqdn = "manticore-elnath.ts.net";
      truenas-ip = "192.168.0.2";
    };
    proxyCount = 4;
    Jelly-Proxy-Configs = builtins.listToAttrs (map (i: let
      num = if i < 9 then "0${toString (i + 1)}" else toString (i + 1);
      name = "jelly-proxy-${num}";
    in {
      inherit name;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit vars; };
        modules = [
          ({ config, pkgs, vars, ... }: {
            networking.hostName = name;
            system.stateVersion = "25.05";
          })
          ./hosts/${name}-hardware.nix
          ./modules/default-modules.nix
          ./hosts/remote-proxy-nodes.nix
        ];
      };
    }) (builtins.genList (i: i) proxyCount));
  in
    {
      nixosConfigurations = Jelly-Proxy-Configs // {
        main-host = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            ./hosts/main-host.nix
            ./hosts/main-host-hardware.nix
            ./modules/default-modules.nix
          ];
        };
        n100-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { vars = vars; };
          modules = [
            ./hosts/n100-1-hardware.nix
            ./hosts/n100-1-module.nix
            ./modules/default-modules.nix
            ./modules/nfs-share-documents.nix
            ./modules/nfs-share-videos.nix
            ./modules/packages-multimedia.nix
            ./modules/packages-pass.nix
            ./modules/packages-terminal.nix
            ./modules/xfce-desktop.nix
          ];
        };
      };
    };
}
