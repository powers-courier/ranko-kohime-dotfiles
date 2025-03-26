{ config, pkgs, proxyHostname, ... }:
{
boot.kernelParams = [
    "i915.enable_guc=2"
  ];
nixpkgs.config.packageOverrides = pkgs: {
  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
};
hardware = {
  enableAllFirmware = true;
  opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = false;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      libva
      libva-utils
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
      vpl-gpu-rt
    ];
  };
};
virtualisation.docker.enable = true;
virtualisation.docker.daemon.settings.live-restore = false;
users = {
  users.jellyfin = {
    isSystemUser = true;
    uid = 8096;
    groups = "jellyfin";
  };
  groups.jellyfin.gid = 8096;
};

}
