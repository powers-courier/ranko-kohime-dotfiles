{ config, lib, ... }: {
  options.tailscaleVPN.enable = lib.mkEnableOption "Enable Tailscale VPN" //
    { default = true; };
  config = lib.mkIf config.tailscaleVPN.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      port = 0;
    };
  };
}
