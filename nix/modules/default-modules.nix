{ config, pkgs, ... }:
{
  imports = [
    ./bootloader-default.nix
    ./flake-enabler.nix
    ./locale.nix
    ./openssh.nix
    ./zram.nix
    ../users/ranko.nix
  ];
}
