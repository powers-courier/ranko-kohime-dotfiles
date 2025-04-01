{
  disko.devices = {
    disk = {
      nvme0 = {
        device = "/dev/nvme0";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
                name = "ESP";
                start = "1MiB";
                end = "1GiB";
                bootable = true;
                content = {
                  type = "filesystem";
                  format = "vfat";
                };
                content.mountpoint = "/boot/efi0";
            }
            {
              name = "zfs";
              start = "1GiB";
              end = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            }
          ];
        };
      };
      nvme1 = {
        device = "/dev/nvme1";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
                name = "ESP";
                start = "1MiB";
                end = "1GiB";
                bootable = true;
                content = {
                  type = "filesystem";
                  format = "vfat";
                };
                content.mountpoint = "/boot/efi1";
            }
            {
              name = "zfs";
              start = "1GiB";
              end = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            }
          ];
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
          };
          "boot" = {
            type = "zfs_fs";
            mountpoint = "/boot";
            options.mountpoint = "legacy";
          };
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
          };
          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "legacy";
          };
        };
      };
    };
  };
}
