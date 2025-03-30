{ config, pkgs, ... }:
{
  services.openssh = {
    banner = "Welcome to... wherever you happen to be\n";
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
