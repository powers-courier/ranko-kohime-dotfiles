{ config, lib, ... }: {
  options.homeManager.enable = lib.mkEnableOption "Enable Home Manager" // { default = false; };
  config = lib.mkIf config.homeManager.enable {
    
  };
}
