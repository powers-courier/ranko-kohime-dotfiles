{ config, lib, ... }:
with lib;
{
  options = {
    services.nixGarbageCollection = {
      enable = mkEnableOption "automatic Nix garbage collection" // {
        default = true;
      };
      dates = mkOption {
        type = types.str;
        default = "monthly";
        description = "How often to run garbage collection";
      };
      options = mkOption {
        type = types.str;
        default = "--delete-older-than 365d";
        description = "Options to pass to nix-collect-garbage";
      };
    };
  };
  config = mkIf config.services.nixGarbageCollection.enable {
    nix.gc = {
      automatic = true;
      dates = config.services.nixGarbageCollection.dates;
      options = config.services.nixGarbageCollection.options;
    };
  };
}
