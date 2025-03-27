{ config, pkgs, proxyHostname, ... }:
{


virtualisation.docker.enable = true;
virtualisation.docker.daemon.settings.live-restore = false;
users = {
  users.jellyfin = {
    isSystemUser = true;
    uid = 8096;
    groups = "jellyfin";
  };
  groups.jellyfin.gid = 8096;
};

}
