{
  hostname = "router-ask";
  system = "x86_64-linux";
  cpuVendor = "intel";
  extraModules = [
    { system.stateVersion = "26.05"; }
#    { flakeyRouter.enable = true; }
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/3b3ab7cd-a88b-4023-ba13-b81e90ba7f99";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/C515-66E7";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
      };
    }
  ];
}
