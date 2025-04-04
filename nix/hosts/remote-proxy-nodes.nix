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
  services.nginx = {
    enable = true;
    virtualHosts."default" = {
      default = true;
      listen = [ { addr = "0.0.0.0"; port = 8096; } ];
      locations."/" = {
        proxyPass = "http://main-host.${vars.tailscale-fqdn}:8096/";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Host "main-host.${vars.tailscale-fqdn}";
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        '';
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
    nginx
    avahi
  ];
}
