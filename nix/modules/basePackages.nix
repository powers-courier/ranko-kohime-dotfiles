{ config, lib, pkgs, ... }: {
  options.basePackages.enable = lib.mkEnableOption "Install standard packages" // { default = true; };
  config = lib.mkIf config.basePackages.enable {
    environment.systemPackages = with pkgs; [
      byobu
      dar
      git
      glances
      sshfs
      tmux
      tree
      unison
    ];
  };
};
