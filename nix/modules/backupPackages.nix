# These packages are for file/disk backups, and disk archiving
# https://github.com/animetosho/par2cmdline-turbo
# http://dar.linux.free.fr/home.html
{ config, lib, pkgs, ... }: {
  options.backupPackages.enable = lib.mkEnableOption "Install backup packages" // { default = true; };
  config = lib.mkIf config.backupPackages.enable {
    environment.systemPackages = with pkgs; [
      dar
      ddrescue
      par2cmdline
      unison
    ];
  };
}
