{ config, pkgs, vars, ... }:
{
  environment.systemPackages = [
    pass
  ];
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "curses";
     enableSSHSupport = true;
  };
  services.pcscd.enable = true;
}
