{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8bfa1c39-f4c5-4b66-8a9e-db7b7b7cbb72";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/19A8-4887";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
