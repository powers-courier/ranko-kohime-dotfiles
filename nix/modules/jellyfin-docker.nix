{ config, pkgs, vars, ... }:
{
  imports = [
    ./packages-multimedia.nix
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;
}
