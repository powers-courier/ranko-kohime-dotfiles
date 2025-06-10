{ config, lib, ... }: {
  options.zramswap.enable = lib.mkEnableOption "Enable zram compressed swap" // { default = true; };
  config = lib.mkIf config.zramswap.enable {
    zramSwap = {
      enable = true;
      priority = 1;
      memoryPercent = 100;
      swapDevices = 1;
    };
  };
};
