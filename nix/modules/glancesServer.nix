{ config, lib, pkgs, ... }:

let
  cfg = config.glancesServer;

  defaultSettings = {
    outputs = {
      left_menu = "network,wifi,connections,ports,diskio,fs,folders,raid,smart,sensors,now";
      separator = "True";
    };
    irq = {
      disable = "True";  # already default, but explicit for clarity
    };
  };

  # Merge user overrides on top of defaults
  glancesConf = pkgs.writeText "glances.conf" (
    lib.generators.toINI { } (lib.recursiveUpdate defaultSettings cfg.settings)
  );
in
{
  options.glancesServer = {
    enable = lib.mkEnableOption "Enable Glances service" // { default = true; };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.glances;
      description = "Glances package to use.";
    };
    settings = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);  # section -> { key = value; }
      default = { };
      example = {
        outputs = {
          left_menu = "network,fs,diskio,sensors";  # even more minimal
        };
        cpu = {
          user_critical = "90";
        };
      };
      description = ''
        Glances configuration as a nested attribute set.
        Converted to INI and written to /etc/glances/glances.conf.
        IRQ is hidden by default (you can still override).
      '';
    };

    # Optional: expose common webserver flags if you want them as real Nix options later
  };
  config = lib.mkIf cfg.enable {
    # Deploy the config file system-wide
    environment.etc."glances/glances.conf".source = glancesConf;
    systemd.services.glances-server = {
      description = "Glances server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/glances -C /etc/glances/glances.conf -w";
        RemainAfterExit = false;
        Restart = "always";
          # Viagra
        DynamicUser = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        NoNewPrivileges = true;
        ProtectHostname = true;
        ProtectClock = true;
      };
    };
  };
}
