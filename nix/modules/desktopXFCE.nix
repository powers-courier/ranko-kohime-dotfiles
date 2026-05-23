{ config, lib, pkgs, ... }: {
  options.desktopXFCE.enable = lib.mkEnableOption "XFCE Desktop" //
    { default = false; };
  config = lib.mkIf config.desktopXFCE.enable {
    environment.systemPackages = with pkgs; [
      thunar-volman
      ulauncher
    ];
    programs.firefox.enable = true;
    services = {
      displayManager = {
        autoLogin = {
          enable = true;
          user = "ranko";
        };
        defaultSession = "xfce";
      };
      xserver = {
        displayManager = {
          lightdm.enable = true;
        };
        desktopManager.xfce.enable = true;
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}
