{ config, pkgs, vars, ... }:
{
  environment.systemPackages = [
    byobu
    glances
    lm_sensors
    neovim
    tmux
  ];
}
