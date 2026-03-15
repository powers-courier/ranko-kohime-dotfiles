{ config, lib, ... }: {
  options.fwupdFirmware.enable = lib.mkEnableOption "Enable Firmware update daemon (fwupd)" // { default = true; };
  config = lib.mkIf config.fwupdFirmware.enable {
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
