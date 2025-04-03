{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deadnix
    emacs
    gprename
    mate.engrampa
    neovim
    python3
    statix
  ];
  networking.hostName = "n100-1";

  programs.firefox.enable = true;

  programs.mosh.enable = true;

  system.stateVersion = "23.11";
}
