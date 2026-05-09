{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5395506b-3569-4992-8d36-bcbeee416cbd";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2069-81C4";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
