{ inputs, lib, mkHost, jellyProxyGenerator ? {}, ... }@args:

let
  jellyProxyGenerator = lib.listToAttrs (map (name: {
    inherit name;
    value = mkHost {
      hostname = name;
      system = "x86_64-linux";
      cpuVendor = "intel";
      role = "server";
      extraModules = [
        hardwareConfigs.${name}
        ({ ... }: {
          cpuLimiterIntel.enable = true;
          jellyfinProxyHost.enable = true;
        })
      ];
    };
  }) jellyProxyHosts);
in

{ inherit jellyProxyGenerator; }
