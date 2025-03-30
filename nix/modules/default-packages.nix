{ config, pkgs, ... }:
{
  environment.systemPackages = [
  byobu
  git
  glances
  lm_sensors
  tmux
  ];
}
