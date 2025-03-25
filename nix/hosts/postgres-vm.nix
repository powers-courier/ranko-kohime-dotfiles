{ config, pkgs, lib, vars, ... }:
{
  imports = [
    ../modules/locale.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "postgres-vm";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 5432 ];
      extraCommands = ''
        iptables -A INPUT -p tcp --dport 5432 -s 192.168.0.0/24 -j ACCEPT
        iptables -A INPUT -p tcp --dport 5432 -j DROP
      '';
    };
    networkmanager.enable = true;
    wireless.enable = false;
  };
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    dataDir = "/var/lib/postgresql/15";
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host jellyfin jellyfin 192.168.0.0/24 md5
    '';
    initialScript = pkgs.writeText "init.sql" ''
      CREATE USER jellyfin WITH PASSWORD 'your-secure-password';
      CREATE DATABASE jellyfin OWNER jellyfin;
    '';
    settings = {
      listen_addresses = lib.mkForce "192.168.0.24";
      port = 5432;
      shared_buffers = "1GB";
      work_mem = "8MB";
      max_connections = 50;
    };
  };
  time.timeZone = vars.timeZern;
  environment.systemPackages = with pkgs; [ postgresql_15 ];
  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
