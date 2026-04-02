{ config, lib, vars, ... }: {
  options.lokale.enable = lib.mkEnableOption "Set Locale" // { default = true; };
  config = lib.mkIf config.lokale.enable {
    i18n = {
      defaultLocale = vars.loKale;
      extraLocaleSettings = {
        LC_ADDRESS = vars.loKale;
        LC_IDENTIFICATION = vars.loKale;
        LC_MEASUREMENT = vars.loKale;
        LC_MONETARY = vars.loKale;
        LC_NAME = vars.loKale;
        LC_NUMERIC = vars.loKale;
        LC_PAPER = vars.loKale;
        LC_TELEPHONE = vars.loKale;
        LC_TIME = vars.loKale;
      };
    };
  };
}
