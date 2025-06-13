{ config, lib, pkgs, ... }: {
  options.backupPackages.enable = lib.mkEnableOption "Install backup packages";
  config = lib.mkIf config.backupPackages.enable {
    environment.systemPackages = with pkgs; [
      dar
      par2cmdline
      unison
    ];
  };
};
