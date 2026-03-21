{ config, lib, pkgs, nix-openclaw, ... }: {
  options.openBot.enable = lib.mkEnableOption "Enable openBot" // { default = false; };
  config = lib.mkIf config.openBot.enable {
    <<openBot-user>>
    <<openBot-systemd-hardening>>
    <<openBot-home-manager>>
  };
}
