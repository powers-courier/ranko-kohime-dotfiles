{ config, pkgs, vars, ... }:
{
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
}
