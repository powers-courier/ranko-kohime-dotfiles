{ config, pkgs, vars, ... }:
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
        ffmpeg
        flac
        handbrake
        intel-compute-runtime
        intel-gpu-tools
        intel-media-driver
        libva
        libva-utils
        libvdpau-va-gl
        mediainfo
        mkvtoolnix
        mkvtoolnix-cli
        vaapiIntel
        vaapiVdpau
        vorbisgain
        vorbis-tools
        vpl-gpu-rt
      ];
    };
  };

}
