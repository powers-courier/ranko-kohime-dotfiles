{ config, pkgs, ... }:
{
  imports = [
    ({ config, vars, ... }: { time.timeZone = vars.timeZern; })
    ./bootloader-default.nix
    ./flake-enabler.nix
    ./locale.nix
    ./openssh.nix
    ./tailscale.nix
    ./zram.nix
    ../users/ranko.nix
  ];
}
