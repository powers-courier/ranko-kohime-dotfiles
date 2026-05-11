{ lib, ... }:

let
  dir = ./platformModules;

  entries = builtins.readDir dir;

  nixFiles = builtins.filter
    (name:
      builtins.match ".*\\.nix" name != null
    )
    (builtins.attrNames entries);

  loaded = builtins.listToAttrs (builtins.map
    (name:
      let
        platform = builtins.replaceStrings [".nix"] [""] name;
      in
      {
        name = platform;
        value = import (dir + "/${name}");
      })
    nixFiles);
in
  loaded
