{ config, pkgs, vars, ... }:
{
  environment.systemPackages = [
    pkgs.pass
  ];
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-curses;
     enableSSHSupport = true;
  };
  services.pcscd.enable = true;
}
