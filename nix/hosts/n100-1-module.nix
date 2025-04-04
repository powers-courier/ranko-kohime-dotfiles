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
  networking = {
    domain = "midgard";
    hostName = "n100-1";
    interfaces = {
      enp2s0 = {
        ipv4.addresses = [{
          address = "192.168.168.20";
          prefixLength = 24;
        }];
        mtu = 9000;
      };
    };
  };

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
