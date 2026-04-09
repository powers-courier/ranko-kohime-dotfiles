{ config, lib, pkgs, ... }: {
  options.jellyfinServer.enable = lib.mkEnableOption "Setup Jellyfin Server"
    // { default = false; };
  config = lib.mkIf config.jellyfinServer.enable {
    boot.kernelParams = [ "i915.enable_guc=2" ];
    nixpkgs.config.allowUnfree = true;
    hardware = {
      enableAllFirmware = true;
      graphics.enable = true;
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
        intel-compute-runtime
        intel-gpu-tools
        intel-media-driver
        jellyfin-ffmpeg
        libva
        libva-utils
        libvdpau-va-gl
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
    systemd.tmpfiles.rules = [
      "d ${config.services.jellyfin.cacheDir} 0750 jellyfin jellyfin - -"
    ];
    users.groups.jellyfin.members = [ "jellyfin" ];
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
