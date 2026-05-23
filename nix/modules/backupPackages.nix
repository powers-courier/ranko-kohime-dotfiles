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
