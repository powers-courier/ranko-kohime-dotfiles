{ mkHost, ... }:
let
  darwinHostsDir = ./../hosts/darwin;
  darwinHostEntries = builtins.readDir darwinHostsDir;
  darwinHostNixFiles = builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames darwinHostEntries);
  autoDarwinHosts = builtins.listToAttrs (builtins.map
    (name:
      let
        hostname = builtins.replaceStrings [".nix"] [""] name;
        hostArgs = import (darwinHostsDir + "/${name}");
      in
        {
          name = hostname;
          value = mkHost (hostArgs // { inherit hostname; });
        }
    )
    darwinHostNixFiles);
in
autoDarwinHosts
