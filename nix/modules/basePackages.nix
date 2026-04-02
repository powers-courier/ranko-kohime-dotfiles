{ config, lib, pkgs, ... }: {
  options.basePackages.enable = lib.mkEnableOption "Install standard packages" // { default = true; };
  config = lib.mkIf config.basePackages.enable {
    environment.systemPackages = with pkgs; [
      byobu
      dmidecode
      git
      glances
      linux-firmware
      lm_sensors
      neovim
      socat
      sshfs
      tmux
      tree
    ];
  };
}
