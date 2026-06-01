{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
  ];
  fancyKeyboards.enable = true;
  packagesMultimedia.enable = true;
  packagesOffice.enable = true;
  programs.wireshark.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    xserver.enable = true;
  };
}
