{ lib, ... }:

let
  rolePaths = [
    ./desktop.nix
    ./laptop.nix
    ./minimal.nix
    ./router.nix
    ./server.nix
  ];
in
lib.genAttrs
  (map (p: lib.removeSuffix ".nix" (builtins.baseNameOf p)) rolePaths)
  (name: import (./. + "/${name}.nix") { inherit lib; })
