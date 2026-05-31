{ config, lib, ... }:
let
  cfg = config.users;
in
{
  config = lib.mkIf cfg.root.enable {
    users.root = {
      openssh.authorizedKeys.keys = [
      ];
    };
  };
}
