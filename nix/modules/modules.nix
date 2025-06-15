{ lib, ... }:
let
  dir = builtins.dirOf (builtins.toString ./.);
  files = lib.filterAttrs
    (name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "modules.nix")
    (builtins.readDir dir);
  imports = lib.mapAttrsToList 
    (name: _: import (dir + "/${name}"))
    files;
in
{ inherit imports; }
