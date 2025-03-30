{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  byobu
  git
  glances
  lm_sensors
  tmux
  ];
}
