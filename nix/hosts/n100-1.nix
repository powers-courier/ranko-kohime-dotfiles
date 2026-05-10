{
  hostname = "n100-1";
  system = "x86_64-linux";
  cpuVendor = "intel";
  extraModules = [
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/3baf4636-0456-44fc-a48b-72fbb49cea3f";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/9BBB-EE1C";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
      };
      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 5120 ];
        };
        hostName = "n100-1";
        interfaces = {
          enp2s0 = {
            ipv4.addresses = [{
              address = "192.168.168.20";
              prefixLength = 24;
            }];
            mtu = 9000;
          };
        };
      };
      system.stateVersion = "24.11";
    }
  ];
}
