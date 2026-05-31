{ config, lib, ... }:
let
  cfg = config.users;

  # List of all users you want to manage with toggles
  userNames = [ "jellyfin" "ranko" "openclaw" ];

  # Helper to create per-user options
  userOption = name: {
    enable = lib.mkEnableOption "User ${name}" // {
      default = true;
    };
  };

in
{
  options.users = {
    enable = lib.mkEnableOption "User management module" // {
      default = true;
    };

    # Per-user toggles
    ranko = userOption "ranko";
    jellyfin = userOption "jellyfin";
    openclaw = userOption "openclaw";
  };
  config = lib.mkIf cfg.enable {
    users = lib.mkMerge [
      (lib.mkIf cfg.jellyfin.enable {
        groups.jellyfin = {
          gid = 8096;
          name = "jellyfin";
        };
        users.jellyfin = {
          extraGroups = [
            "render"
            "video"
          ];
          group = "jellyfin";
          isNormalUser = true;
          isSystemUser = lib.mkForce false;
          uid = 8096;
        };
      })
      (lib.mkIf cfg.openclaw.enable {
        groups.openclaw = {
          gid = 18789;
          name = "openclaw";
        };
        users.openclaw = {
          createHome = true;
          group = "openclaw";
          home = "/var/lib/openclaw";
          isSystemUser = true;
          shell = "/run/current-system/sw/bin/bash";
          uid = 18789;
        };
      })
      (lib.mkIf cfg.ranko.enable {
        users.ranko = {
          isNormalUser = true;
          description = "Ranko Kohime";
          extraGroups = [
            "networkmanager"
            "video"
            "wheel"
          ]
            ++ lib.optionals cfg.jellyfin.enable [ "jellyfin" ]
            ++ lib.optionals (lib.attrByPath [ "virtualisation" "docker" "enable" ] false config) [ "docker" ];
          uid = 1000;
        };
      })
      
    ];
  };
}
