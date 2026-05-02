{
  hostname = "main-host";
  system = "x86_64-linux";
  cpuVendor = "intel";
  extraModules = [
    { jellyfinServer.enable = true; }
#    { services.LubeLogger.enable = true; }
    { zfsBootOptions.enable = true; }
    {
      fileSystems = {
        "/" =
        { device = "zroot/root";
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
        "/home" = {
          device = "zroot/home";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/A0D5-9779";
          fsType = "vfat";
          options = [ "fmask=0022" "dmask=0022" ];
        };
      };
      networking = {
        hostId = "2b7f3c3a";
        interfaces = {
          enp4s0 = {
            ipv4.addresses = [{
              address = "192.168.168.25";
              prefixLength = 24;
            }];
            mtu = 9000;
          };
        };
      };
      system.stateVersion = "25.05";
    }
  ];
}
