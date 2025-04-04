{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deadnix
    emacs
    gprename
    mate.engrampa
    neovim
    python3
    statix
  ];
  networking.hostName = "n100-1";

  programs.firefox.enable = true;

  programs.mosh.enable = true;

  system.stateVersion = "23.11";

  users = {
    groups.jellyfin = {
      gid = 8096;
      name = "jellyfin";
    };
    users.jellyfin = {
      extraGroups = [ "video" ];
      group = "jellyfin";
      isNormalUser = true;
      isSystemUser = lib.mkForce false;
      uid = 8096;
    };
  };
}
