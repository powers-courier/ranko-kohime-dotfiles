{ config, pkgs, ... }:
{
  services.openssh = {
    banner = "Welcome to ";
    enable = true;
    extraConfig ="";
    openFirewall = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      PrintMotd = true;
      StrictModes = true;
      X11Forwarding = true;
    };
  };
}
