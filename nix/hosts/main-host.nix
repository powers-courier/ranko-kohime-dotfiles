{ config, pkgs, ... }:
{
  imports = [
    ../modules/default-modules.nix
    ../modules/nfs-share-documents.nix
    ../modules/nfs-share-videos.nix
    ../modules/packages-multimedia.nix
    ../modules/xfce-desktop.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  networking = {
    domain = "midgard";
    hostId = "2b7f3c3a";
    hostName = "main-host";
    interfaces = {
      enp4s0 = {
        ipv4.addresses = [{
          address = "192.168.168.25";
          prefixLength = 24;
        }];
        mtu = 9000;
      };
    };
  };

  system.stateVersion = "25.05";

  services.jellyfin = {
    enable = true;
    group = "jellyfin";
    openFirewall = true;
    user = "jellyfin";
  };

  users = {
    groups.jellyfin = {
      gid = 8096;
      name = "jellyfin";
    };
    users.jellyfin = {
      extraGroups = [ "video" ];
      group = "jellyfin";
      isNormalUser = true;
      isSystemUser = lib.mkForce false;
      uid = 8096;
    };
  };
}
