{ config, lib, pkgs, ... }: with lib;
let
  cfg = config.services.lubelogger;
  dataDir = "${cfg.dataDir}/data";
  keysDir = "${cfg.dataDir}/keys";
in {
  imports = [
      ../lubelogger-apple-touch-overlay.nix   # ← temporary overlay
    ];
  options.services.lubelogger = {
    enable = mkEnableOption "LubeLogger vehicle maintenance tracker";
    dataDir = mkOption {
      type = types.str;
      default = "/LubeLogger";
      description = "Base directory for LubeLogger data (data and keys subdirs will be created).";
    };
    port = mkOption {
      type = types.port;
      default = 5000;
      description = "Port the LubeLogger web UI listens on.";
    };
    image = mkOption {
      type = types.str;
      default = "ghcr.io/hargata/lubelogger:latest";
      description = "Docker image to use for LubeLogger.";
    };
    environment = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = ''
        Additional environment variables passed to the container.
        Use this for POSTGRES_CONNECTION, MailConfig_*, OpenIDConfig_*, EnableAuth, etc.
        See: https://docs.lubelogger.com/Advanced/Environment%20Variables/
      '';
      example = {
        POSTGRES_CONNECTION = "Host=localhost;Database=lubelogger;Username=lubelogger;Password=supersecret";
        EnableAuth = "true";
        LC_ALL = "en_US.UTF-8";
      };
    };
    extraOptions = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Extra flags passed to the Docker container (e.g. --network).";
    };
  };
  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir} 0755 root root -"
      "d ${dataDir} 0755 root root -"
      "d ${keysDir} 0755 root root -"
    ];
    virtualisation.oci-containers.containers.lubelogger = {
      image = cfg.image;
      autoStart = true;
      ports = [ "${toString cfg.port}:5000" ];
      volumes = [
        "${dataDir}:/App/data"
        "${keysDir}:/root/.aspnet/DataProtection-Keys"
      ];
      environment = cfg.environment;
      extraOptions = cfg.extraOptions;
      restartPolicy = "unless-stopped";
    };
    networking.firewall.allowedTCPPorts = mkIf (cfg.port != 0) [ cfg.port ];
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "lubelogger-logs" ''
        ${pkgs.docker}/bin/docker logs -f lubelogger
      '')
    ];
    warnings = mkIf (cfg.environment ? POSTGRES_CONNECTION == false) [
      "LubeLogger is using the built-in SQLite by default. For production, consider setting services.lubelogger.environment.POSTGRES_CONNECTION or adding a PostgreSQL service."
    ];
  };
}
