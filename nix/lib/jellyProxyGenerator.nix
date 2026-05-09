{  lib, mkHost, autoHardware, ... }:

let
  jellyProxyHosts = builtins.filter
    (name: lib.hasPrefix "jelly-proxy-" name)
    (lib.attrNames autoHardware);

  jellyProxyGenerator = lib.listToAttrs (map (name: {
    inherit name;
    value = mkHost {
      hostname = name;
      system = "x86_64-linux";
      cpuVendor = "intel";
      role = "server";
      extraModules = [
        autoHardware.${name}
        ({ ... }: {
          cpuLimiterIntel.enable = true;
          jellyfinProxyHost.enable = true;
        })
      ];
    };
  }) jellyProxyHosts);

in
{ inherit jellyProxyGenerator; }
