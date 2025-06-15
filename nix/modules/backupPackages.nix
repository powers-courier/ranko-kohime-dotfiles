{ config, lib, pkgs, ... }: {
  options.backupPackages.enable = lib.mkEnableOption "Install backup packages";
  config = lib.mkIf config.backupPackages.enable {
    environment.systemPackages = with pkgs; [
      dar
      ddrescue
      par2cmdline
      unison
    ];
  };
};
