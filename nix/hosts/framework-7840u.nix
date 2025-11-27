{ config, pkgs, lib, ... }: {
  networking.hostname = "framework-7840u";
  framework-7840u = {
    fileSystems = {
      "/" = {
        device = "zroot/root";
        fsType = "zfs";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/F83E-8932";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
      "/home" = {
        device = "zroot/home";
        fsType = "zfs";
      };
      "/nix" = {
        device = "zroot/nix";
        fsType = "zfs";
      };
      "/var" = {
        device = "zroot/var";
        fsType = "zfs";
      };
    };
    swapDevices = [ ];
  };
}
