{ config, lib, ... }:
let
  cfg = config.users;
in
{
  config = lib.mkIf cfg.ranko.enable {
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
  };
}
