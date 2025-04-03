{ config, pkgs, vars, ... }:
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8096 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints.web.address = ":8096";
      http = {
        routers = {
          jellyfin = {
            rule = "Host(`*`)"; # Catch-all for any hostname (or leave unspecified)
            service = "jellyfin";
          };
        };
        services = {
          jellyfin = {
            loadBalancer = {
              servers = [{ url = "http://main-host.${vars.tailscale-fqdn}:8096"; }];
            };
          };
        };
      };
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };
  environment.etc."avahi/services/jellyfin.service".text = ''
    <?xml version="1.0" standalone='no'?>
    <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
    <service-group>
      <name>Jellyfin Proxy</name>
      <service>
        <type>_http._tcp</type>
        <port>8096</port>
        <txt-record>description=Jellyfin Media Server Proxy</txt-record>
      </service>
    </service-group>
  '';

  environment.systemPackages = with pkgs; [
    tailscale
    traefik
    avahi
  ];

  systemd.services.traefik = {
    after = [ "tailscale.service" ];
    wants = [ "tailscale.service" ];
  };
}
