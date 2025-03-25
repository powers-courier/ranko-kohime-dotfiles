{ config, pkgs, ... }:
{
  zramSwap = {
    enable = true;
    priority = 1;
    memoryPercent = 100;
    swapDevices = 1;
  };
}
