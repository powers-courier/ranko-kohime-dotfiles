{ config, lib, ... }: {
  options.garbageCollection.enable = lib.mkEnableOption "Enable garbage collection in the Nix store, set to a conservative default" // { default = true; };
  config = lib.mkIf config.garbageCollection.enable {
    nix.gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 365d";
    };
  };
};
