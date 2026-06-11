{ config, lib, pkgs, ... }: {
  options.packagesOffice.enable = lib.mkEnableOption "Install Office packages" //
    { default = false; };
  config = lib.mkIf config.packagesOffice.enable {
    environment.systemPackages = with pkgs; [
      evince
      gnucash
      libreoffice-fresh
      pdflatex
    ];
  };
}
