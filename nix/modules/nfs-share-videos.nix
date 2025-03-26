{ config, pkgs, vars, ... }:
{
  fileSystems = {
    "/Mounts/JellyConfig" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Videos/JellyConfig";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Videos" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Videos";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/youtube-dl" = {
      device = "${vars.truenas-ip}:/mnt/youtube-dl/youtube-dl";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
  };
}
