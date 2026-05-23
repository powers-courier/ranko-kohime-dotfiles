{ config, lib, ... }: {
  options.dangerSwap.enable = lib.mkEnableOption "Enable zram compressed swap" //
    { default = true; };
  config = lib.mkIf config.dangerSwap.enable {
    zramSwap = {
      enable = true;
      priority = 1;
      memoryPercent = 100;
      swapDevices = 1;
    };
  };
}
