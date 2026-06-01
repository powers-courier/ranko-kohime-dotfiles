{ config, lib, pkgs, ... }: {
  options.packagesMultimedia.enable = lib.mkEnableOption "Install multimedia packages" //
    { default = false; };
  config = lib.mkIf config.packagesMultimedia.enable {
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
      vlc
      vorbisgain
      vorbis-tools
    ];
  };
}
