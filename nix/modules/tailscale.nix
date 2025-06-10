{ config, lib, ... }: {
  options.tailscale.enable = lib.mkEnableOption "Enable Tailscale VPN" // { default = true; };
  config = lib.mkIf config.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      port = 0;
    };
  };
};
