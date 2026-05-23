{ config, lib, pkgs, ... }: {
  options.multimediaPackages.enable = lib.mkEnableOption "Install multimedia packages" //
    { default = false; };
  config = lib.mkIf config.multimediaPackages.enable {
    environment.systemPackages = with pkgs; [
      flac
      gimp3-with-plugins
      handbrake
      mediainfo
      mkvtoolnix
      mpv
      mpvc
      python312Packages.musicbrainzngs
      quodlibet
      vorbisgain
      vorbis-tools
    ];
  };
}
