{ config, lib, pkgs, ... }: {
  options.packagesPass.enable = lib.mkEnableOption "Install the Unix Password Manager"
    // { default = false; };
  config = lib.mkIf config.packagesPass.enable {
    environment.systemPackages = with pkgs; [
      pass
      pinentry-curses
    ];
    programs.gnupg.agent = {
       enable = true;
       pinentryPackage = pkgs.pinentry-curses;
       enableSSHSupport = true;
    };
    services.pcscd.enable = true;
  };
}
