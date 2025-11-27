{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.jellyfin-server;
in {
  # Define the option for enabling/disabling the Jellyfin module
  options.services.jellyfin-server = {
    enable = mkEnableOption "Jellyfin media server with hardware acceleration";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "i915.enable_guc=2" ];
    nixpkgs.config.allowUnfree = true;
    hardware = {
      enableAllFirmware = true;
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-compute-runtime
          intel-media-driver
          libva
        ];
      };
    };
    services.jellyfin = {
      enable = true;
      group = "jellyfin";
      openFirewall = true;
      user = "jellyfin";
      dataDir = "/var/lib/jellyfin"; # Default data directory
      cacheDir = "/var/cache/jellyfin"; # Cache directory for transcoding
    };
    environment = {
      sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
      systemPackages = with pkgs; [
        intel-gpu-tools
        jellyfin-ffmpeg
        libva-utils
        libvdpau-va-gl
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
    systemd.tmpfiles.rules = [
      "d ${config.services.jellyfin.cacheDir} 0750 jellyfin jellyfin - -"
    ];
    users.jellyfin = lib.mkIf config.user.jellyfin.enable {
      extraGroups = [ "render" "video" ];
      group = "jellyfin";
      isNormalUser = true;
      isSystemUser = lib.mkForce false;
      uid = 8096;
      gid = 8096;
    };
    systemd.services.jellyfin = {
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
