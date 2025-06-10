{ config, lib, ... }: {
  options.autoUpgrade.enable = lib.mkEnableOption "Enable automatic upgrades from flake Git repo" // {default = false; };
  config = lib.mkIf config.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "git+https://github.com/your/repo?ref=main";
      dates = "weekly";
      allowReboot = false; # Optional: avoid reboots
    };
  };
};
