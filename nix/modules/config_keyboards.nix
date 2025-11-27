{ config, lib, ... }:
{
{
  environment.systemPackages = with pkgs; [
    system76-keyboard-configurator
  ];
}
hardware.keyboard.zsa.enable = true;
}
