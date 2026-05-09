{ mkHost, ... }:

let

    hostsDir = ./../hosts;

    hostEntries = builtins.readDir hostsDir;

    hostNixFiles = builtins.filter
      (name: builtins.match ".*\\.nix" name != null)
      (builtins.attrNames hostEntries);

  autoLinuxHosts =  builtins.listToAttrs (builtins.map
    (name:
      let
        hostname = builtins.replaceStrings [".nix"] [""] name;
        hostArgs = import (hostsDir + "/${name}");
      in
        {
          name = hostname;
          value = mkHost (hostArgs // { inherit hostname; });
        }
    )
    hostNixFiles);

in
  autoLinuxHosts
