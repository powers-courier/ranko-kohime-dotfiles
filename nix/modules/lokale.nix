{ config, lib, vars, ... }:
let
loKale = "en_US.UTF-8";
in
{
  options.lokale.enable = lib.mkEnableOption "Set Locale" // { default = true; };
  config = lib.mkIf config.lokale.enable {
    i18n = {
      defaultLocale = loKale;
      extraLocaleSettings = {
        LC_ADDRESS = loKale;
        LC_IDENTIFICATION = loKale;
        LC_MEASUREMENT = loKale;
        LC_MONETARY = loKale;
        LC_NAME = loKale;
        LC_NUMERIC = loKale;
        LC_PAPER = loKale;
        LC_TELEPHONE = loKale;
        LC_TIME = loKale;
      };
    };
    time.timeZone = lib.mkDefault "Etc/UTC";
  };
}
