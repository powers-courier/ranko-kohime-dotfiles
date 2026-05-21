{ lib, pkgs, ... }:
{
  boot.kernelParams = [ "quiet" "splash" ];
  networking.firewall.enable = true;
  networking.networkmanager.enable = lib.mkForce false;
  security.disableWireless.enable = true;
  services.printing.enable = lib.mkForce false;
  services.xserver.enable = lib.mkDefault false;
}
