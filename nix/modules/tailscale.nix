{ config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    port = 0;
  }
}
