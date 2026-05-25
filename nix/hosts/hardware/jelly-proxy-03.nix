{ listFromFile, ... }:
let
  nfsCommonOptions = listFromFile.readLines ./../../settings/nfs-common-options.txt;
in
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c1de1e73-2138-4286-888b-ef9b5d5b2eae";
      fsType = "ext4";
      options = [ "defaults" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/5320-4C3E";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/Mounts/Music" = {
      device = "192.168.1.22:/mnt/tank2/Snapshotted/Music";
      fsType = "nfs";
      options = nfsCommonOptions;
    };
    "/Mounts/Videos" = {
      device = "192.168.1.22:/mnt/tank2/Snapshotted/Videos";
      fsType = "nfs";
      options = nfsCommonOptions;
    };
    "/Mounts/youtube-dl" = {
      device = "192.168.0.2:/mnt/youtube-dl/youtube-dl";
      fsType = "nfs";
      options = nfsCommonOptions;
    };
  };
  system.stateVersion = "25.05";
}
