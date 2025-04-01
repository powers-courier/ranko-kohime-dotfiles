{ config, pkgs, ... }:
{
  imports = [
    ../modules/default-modules.nix
    ../modules/nfs-share-documents.nix
    ../modules/nfs-share-videos.nix
    ../modules/packages-multimedia.nix
    ../modules/xfce-desktop.nix
    ../users/jellyfin.nix
  ];

  networking.hostName = "main-host";
  networking.hostID = "2b7f3c3a";

  system.stateVersion = "25.05";

  services.jellyfin = {
    cacheDir = "\${cfg.dataDir}/cache";
    enable = true;
    openFirewall = true;
  };

}
