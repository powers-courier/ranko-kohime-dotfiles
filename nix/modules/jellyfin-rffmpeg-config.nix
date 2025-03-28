{ config, pkgs, vars, ... }:
environment.etc."rffmpeg/rffmpeg.yml".text = ''
  hosts:
    - host: n200-1\n  user: jellyfin
    - host: n200-2\n  user: jellyfin
    - host: n200-3\n  user: jellyfin
'';
