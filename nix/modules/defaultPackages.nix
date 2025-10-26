{ config, lib, pkgs, ... }:

with lib;

{
  options.programs.defaultPackages = {
    enable = mkEnableOption "standard development packages" // {
      default = true;
      description = "Whether to enable the standard set of development packages";
    };

    # Optional: allow users to extend the package list
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional packages to install alongside the standard development packages";
      example = literalExpression "[ pkgs.ripgrep pkgs.fd ]";
    };
  };

  config = mkIf config.programs.defaultPackages.enable {
    environment.systemPackages = with pkgs; [
      byobu      # Front-end for Tmux
      lm_sensors
      neovim     # For default editor options
      tree       # Somehow not included in the base
      tmux       # Terminal multiplexer
      yazi       # Rust-based file manager, better than Ranger
    ] ++ config.programs.defaultPackages.extraPackages;
  };
}
