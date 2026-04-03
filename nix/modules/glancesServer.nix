{ config, lib, pkgs, ... }: {
  options.glancesServer.enable = lib.mkEnableOption "Enable Glances service" // { default = true; };
  config = lib.mkIf config.glancesServer.enable {
    systemd.services.glances-server = {
      description = "Glances server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.glances}/bin/glances -w";
        RemainAfterExit = false;
        Restart = "always";
      };
    };
  };
}
