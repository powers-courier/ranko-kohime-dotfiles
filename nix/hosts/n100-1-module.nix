{ config, pkgs, ... }:
{
  environment.systemPackages = [
  ];
  networking.hostName = "n100-1";

  programs.firefox.enable = true;

  programs.mosh.enable = true;

  system.stateVersion = "23.11";
}
