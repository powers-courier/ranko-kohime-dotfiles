{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/18687194-1d96-47af-b2ed-3bab9f7bf253";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DFE8-3B70";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
