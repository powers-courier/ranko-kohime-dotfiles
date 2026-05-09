{ inputs, lib, mkHost, autoHardware, ... }@args:

let
  libDir = ./.;

  entries = builtins.readDir libDir;

  nixFiles = builtins.filter
    (name:
      builtins.match ".*\\.nix" name != null
      && name != "autoLib.nix"
                 # Auto loaded separately by the flake
      && name != "autoHardware.nix"
    )
    (builtins.attrNames entries);

  importedLibs = builtins.listToAttrs (builtins.map
    (name:
      let
        baseName = builtins.replaceStrings [".nix"] [""] name;
        imported = import (libDir + "/${name}") args;
      in
      {
        name = baseName;
        value = imported;
      })
    nixFiles);
in
  importedLibs
