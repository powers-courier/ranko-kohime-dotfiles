{ config, lib, ... }: {
  options.zramSwap.enable = lib.mkEnableOption "Enable zram compressed swap" // { default = true; };
  config = lib.mkIf config.zramSwap.enable {
    zramSwap = {
      enable = true;
      priority = 1;
      memoryPercent = 100;
      swapDevices = 1;
    };
  };
}
