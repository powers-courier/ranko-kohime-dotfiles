{ config, lib, ... }: {
  options.defaultSettings.enable = lib.mkEnableOption "Default system settings" // { default = true; };
  config = lib.mkIf config.defaultSettings.enable {
    hardware.enableRedistributableFirmware = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    time.timeZone = lib.mkDefault "Etc/UTC";
  };
}
