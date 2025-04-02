{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    emacs
    gprename
    mate.engrampa
    neovim
    python3
  ];
  networking.hostName = "n100-1";

  programs.firefox.enable = true;

  programs.mosh.enable = true;

  system.stateVersion = "23.11";
}
