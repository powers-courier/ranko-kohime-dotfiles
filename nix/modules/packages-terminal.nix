{ config, pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    byobu
    glances
    lm_sensors
    neovim
    ranger
    tmux
    tree
  ];
}
