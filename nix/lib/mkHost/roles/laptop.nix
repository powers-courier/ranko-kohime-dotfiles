{ pkgs, ... }: {
  imports = [ ./desktop.nix ];
  environment.systemPackages = with pkgs; [
    byobu # Just to have non-empty list
  ];
  laptopFixes.enable = true;
}
