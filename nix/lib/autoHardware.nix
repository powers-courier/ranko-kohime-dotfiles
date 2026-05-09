{ ... }:

let
  hardwareDir = ./../hosts/hardware;

  entries = builtins.readDir hardwareDir;

  nixFiles = builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames entries);

  autoHardware = builtins.listToAttrs (builtins.map
    (name:
      let
        hostName = builtins.replaceStrings [".nix"] [""] name;
      in
      {
        name = hostName;
        value = import (hardwareDir + "/${name}");
      })
    nixFiles);
in
  { inherit autoHardware; }
