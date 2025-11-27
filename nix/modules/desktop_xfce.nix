{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
}
