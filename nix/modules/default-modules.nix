{ config, pkgs, vars, ... }:
{
  time.timeZone = vars.timeZern;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  i18n = {
    defaultLocale = vars.loKale;
    extraLocaleSettings = {
      LC_ADDRESS = vars.loKale;
      LC_IDENTIFICATION = vars.loKale;
      LC_MEASUREMENT = vars.loKale;
      LC_MONETARY = vars.loKale;
      LC_NAME = vars.loKale;
      LC_NUMERIC = vars.loKale;
      LC_PAPER = vars.loKale;
      LC_TELEPHONE = vars.loKale;
      LC_TIME = vars.loKale;
    };
  };
  networking.networkmanager.enable = true;
  services.openssh = {
    banner = "Welcome to... wherever you happen to be\n";
    enable = true;
    extraConfig ="";
    openFirewall = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      PrintMotd = true;
      StrictModes = true;
      X11Forwarding = true;
    };
  };
  environment.systemPackages = with pkgs; [
    byobu
    git
    glances
    lm_sensors
    tmux
  ];
  services.tailscale = {
    enable = true;
    openFirewall = true;
    port = 0;
  };
  zramSwap = {
    enable = true;
    priority = 1;
    memoryPercent = 100;
    swapDevices = 1;
  };
  users.users.ranko = {
    isNormalUser = true;
    description = "Ranko Kohime";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
