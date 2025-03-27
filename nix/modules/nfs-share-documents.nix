{ config, pkgs, vars, ... }:
{
  fileSystems = {
    "/Mounts/Disks" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Disks";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Documents" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Documents";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Downloads" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Downloads";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/LGC_Actual" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/LGC_Actual";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/LGC_Lore_Table" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/LGC_Lore_Table";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Library" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Library";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Music" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Music";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
    "/Mounts/Workspace" = {
      device = "${vars.truenas-ip}:/mnt/Svartalfheim/Workspace";
      fsType = "nfs";
      options = [ "nfsvers=4" "hard" "users" "rw" "exec" ];
    };
  };
}
