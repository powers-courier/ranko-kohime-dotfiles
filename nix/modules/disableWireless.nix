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
    networking.networkmanager = {
      enable = lib.mkDefault true;  # keep NM if used for wired, but kill wireless
      wifi.backend = lib.mkForce "none";
      wifi.scanRandMacAddress = false;
      wifi.powersave = false;
    };
    networking.wireless = {
      enable = lib.mkForce false;
      iwd.enable = lib.mkForce false;
    };
    hardware.bluetooth = {
      enable = lib.mkForce false;
      powerOnBoot = lib.mkForce false;
    };
    services.blueman.enable = lib.mkForce false;
    networking.modemmanager.enable = lib.mkForce false;
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="rfkill", ATTR{type}=="0|1|2", ATTR{soft}="1", RUN+="${pkgs.util-linux}/bin/rfkill block all"
      ACTION=="change", SUBSYSTEM=="rfkill", ATTR{type}=="0|1|2", ATTR{soft}="0", RUN+="${pkgs.util-linux}/bin/rfkill block all"
    '';
    boot.blacklistedKernelModules = [
      "ath10k_core"
      "ath10k_pci"
      "ath9k"
      "ath9k_htc"
      "b43"
      "bcma"
      "bluetooth"
      "brcmfmac"
      "brcmsmac"
      "btbcm"
      "btintel"
      "btrtl"
      "btusb"
      "cdc_mbim"
      "cdc_ncm"
      "iwlmvm"
      "iwlwifi"
      "iwlwifi_opregion"
      "mt7601u"
      "mt76x0u"
      "mt76x2u"
      "mt7921_common"
      "mt7921e"
      "mt7921u"
      "option"
      "qmi_wwan"
      "rtlwifi"
      "rtw88_core"
      "rtw88_pci"
      "usbserial"
    ];
     # This option does not exist
#    boot.initrd.blacklistedKernelModules = config.boot.blacklistedKernelModules;
    environment.systemPackages = with pkgs; [
      bluez-tools  # even though bluetooth is off, useful for debugging
      iw
      util-linux   # for rfkill
    ];
    environment.etc."motd".text = lib.mkAfter ''
      NOTICE: Wireless (Wi-Fi / Bluetooth / WWAN) is forcibly disabled on this system.
    '';
  };
}
