{ config, lib, ... }: {
  options.fwupd.enable = lib.mkEnableOption "Enable Firmware update daemon (fwupd)" // { default = true; };
  config = lib.mkIf config.fwupd.enable {
    services.fwupd = {
      daemonSettings = {
        IgnorePower = true;
      };
      enable = true;
#      extraRemotes = [];
#      uefiCapsuleSettings = {};
    };
  };
}
