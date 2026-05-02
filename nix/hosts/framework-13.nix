{
  hostname = "framework-13";
  system = "x86_64-linux";
  cpuVendor = "intel";
  role = "laptop";
  extraModules = [
    { desktopXFCE.enable = true; }
    { zfsBootOptions.enable = true; }
    {
      fileSystems = {
        "/" = {
          device = "zroot/root";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/F83E-8932";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
        "/home" = {
          device = "zroot/home";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };
        "/nix" = {
          device = "zroot/nix";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };
        "/var" = {
          device = "zroot/var";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };
      };
      networking = {
        hostId = "af2f1b7f";
      };
      swapDevices = [ ];
      system.stateVersion = "25.05";
    }
  ];
}
