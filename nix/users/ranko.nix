{ config, ... }:
{
  users.users.ranko = {
    isNormalUser = true;
    description = "Ranko Kohime";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
