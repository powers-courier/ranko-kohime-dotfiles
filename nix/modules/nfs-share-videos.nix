{ config, pkgs, ... }:
{
  fileSystems = {
    "/Mounts/JellyConfig" = {
      device = "${truenas-ip}:/mnt/Svartalfheim/Videos/JellyConfig";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Videos" = {
      device = "${truenas-ip}:/mnt/Svartalfheim/Videos";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/youtube-dl" = {
      device = "${truenas-ip}:/mnt/youtube-dl/youtube-dl";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
  };
}
