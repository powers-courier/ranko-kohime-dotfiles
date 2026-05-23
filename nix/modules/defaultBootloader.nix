{ config, lib, ... }: {
  options.defaultBootloader.enable = lib.mkEnableOption "Set default bootloader" //
    { default = true; };
  config = lib.mkIf config.defaultBootloader.enable {
    boot = {
      initrd.availableKernelModules = [ "ahci" "nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci" ];
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
