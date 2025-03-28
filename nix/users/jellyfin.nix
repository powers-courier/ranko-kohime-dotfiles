{ config, ... }:
{
  users = {
    users.jellyfin = {
      isSystemUser = true;
      uid = 8096;
      groups = "jellyfin";
    };
    groups = {
      jellyfin.gid = 8096;
      video.members = [ "jellyfin" ];
    };
  };
}
