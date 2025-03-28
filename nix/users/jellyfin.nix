{ config, ... }:
{
  users = {
    groups.jellyfin = {
      gid = 8096;
      name = "jellyfin";
    };
    users.jellyfin = {
      extraGroups = [ "video" ];
      group = "jellyfin";
      isNormalUser = true;
      uid = 8096;
    };
  };
}
