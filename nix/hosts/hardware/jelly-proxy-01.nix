{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5803de2e-1612-469e-862f-acd51884606e";
      fsType = "ext4";
      options = [ "defaults" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7655-7B22";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
