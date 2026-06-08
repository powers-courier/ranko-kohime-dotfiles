{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e2feb3c4-8705-40f5-a21b-91429d3e1bcd";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/B830-073C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
