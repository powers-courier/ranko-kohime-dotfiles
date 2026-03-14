{ config, lib, vars, ... }: {
  options.defaultNetworking = {
    enable = lib.mkEnableOption "Default network settings" // { default = true; };
    useIwd = lib.mkEnableOption "Enable IWD Wireless Client" // { default = true; };
  };
  config = lib.mkIf config.defaultNetworking.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
      wireless.iwd = lib.mkIf config.defaultNetworking.useIwd {
        enable = lib.mkDefault true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
  };
}
