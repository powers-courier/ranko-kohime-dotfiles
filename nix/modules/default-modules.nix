{ config, pkgs, ... }:
{
  imports = [
    (
      { config, vars, ... }:
        {
          time.timeZone = vars.timeZern;
        }
    )
    ./bootloader-default.nix
    ./flake-enabler.nix
    ./locale.nix
    ./networking.nix
    ./openssh.nix
    ./default-packages.nix
    ./tailscale.nix
    ./zram.nix
    ../users/ranko.nix
  ];
}
