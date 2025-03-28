{ config, pkgs, vars, ... }:
{
  boot.kernelParams = [
    "i915.enable_guc=2"
  ];
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        ffmpeg-full
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
        vaapiIntel
        vaapiVdpau
        vorbisgain
        vorbis-tools
        vpl-gpu-rt
      ];
    };
  };

}
