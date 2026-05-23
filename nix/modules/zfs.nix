{ config, lib, ... }: {
  options = {
    zfsBootOptions.enable = lib.mkEnableOption "Boot settings for root on ZFS hosts" //
      { default = false; };
    zfsOptions.enable = lib.mkEnableOption "Common settings for ZFS pools" //
      { default = false; };
    zfsSanoid.enable = lib.mkEnableOption "Enable Sanoid/Syncoid for ZFS" //
      { default = false; };
  };
  config = lib.mkMerge [
      # When zfsBootOptions is enabled, force the others on
      (lib.mkIf config.zfsBootOptions.enable {
        zfsOptions.enable = true;
        zfsSanoid.enable = true;

        boot = {
          loader.grub.enable = false;
          supportedFilesystems = [ "zfs" ];
          zfs.forceImportRoot = false;
        };
      })
    (lib.mkIf config.zfsSanoid.enable {
      services = {
        sanoid = {
          enable = true;
        };
        syncoid = {
          enable = true;
        };
      };
    })
    (lib.mkIf config.zfsOptions.enable {
      boot.kernelParams = [ "zfs.zfs_arc_max=1073741824" ];
      services = {
        zfs = {
          autoScrub = {
            enable = true;
            interval = "monthly";
            pools = [ "zroot" ];
          };
          trim.enable = true;
        };
      };
    })
  ];
}
