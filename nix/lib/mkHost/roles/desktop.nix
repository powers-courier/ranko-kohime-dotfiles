{ pkgs, ... }:
{
  fancyKeyboards.enable = true;
  multimediaPackages.enable = true;
  services.xserver.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  environment.systemPackages = with pkgs; [
    evince
    firefox
    libreoffice-fresh
    vlc
  ];
}
