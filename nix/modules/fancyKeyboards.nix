{ config, lib, pkgs, ... }: {
  options.fancyKeyboards.enable = lib.mkEnableOption "Configuration for fancy keyboards" // { default = false; };
  config = lib.mkIf config.fancyKeyboards.enable {
    environment.systemPackages = with pkgs; [
      system76-keyboard-configurator
    ];
    hardware.keyboard.zsa.enable = true;
  };
}
