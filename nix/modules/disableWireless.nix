{ config, lib, pkgs, ... }:
let
  cfg = config.security.disableWireless;
in
{
  options.security.disableWireless = with lib; {
    enable = mkEnableOption "forcibly disable all wireless connectivity (Wi-Fi, Bluetooth, WWAN, etc.)"
      // { default = false; };
  };
  config = lib.mkIf cfg.enable {
    <<wifiKill-networkManager>>
    <<wifiKill-supplicants>>
    <<wifiKill-bluetooth>>
    networking.modemmanager.enable = lib.mkForce false;
    <<wifiKill-rfkill>>
    <<wifiKill-blacklistModules>>
     # This option does not exist
#    boot.initrd.blacklistedKernelModules = config.boot.blacklistedKernelModules;
    <<wifiKill-packages>>
    <<wifiKill-logMessage>>
  };
}
