{ config, lib, ... }: {
  options.laptopFixes.enable = lib.mkEnableOption "Enable fixes for laptops" // { default = false; };
  config = lib.mkIf config.laptopFixes.enable {
    boot.kernelParams = [ "mem_sleep_default=deep" ];
    powerManagement = {
      cpuFreqGovernor = lib.mkDefault "powersave";
      enable = true;
      powertop.enable = true;
    };
    services.tlp.enable = true;
  };
}
