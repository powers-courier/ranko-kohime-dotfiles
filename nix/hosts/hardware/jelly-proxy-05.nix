{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f97df9e0-b2ac-4e29-84ba-12f27bd54b07";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0283-E117";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  system.stateVersion = "25.05";
}
