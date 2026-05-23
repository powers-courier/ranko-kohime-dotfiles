{ ... }:
let
  modulesDir = ./../modules;
  moduleEntries = builtins.readDir modulesDir;
  nixModuleFiles = builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames moduleEntries);
  autoModules =  builtins.listToAttrs (builtins.map
    (name: {
      name = builtins.replaceStrings [".nix"] [""] name;
      value = import (modulesDir + "/${name}");
    })
    nixModuleFiles);
in
  autoModules
