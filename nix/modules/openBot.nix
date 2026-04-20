{ config, home-manager, lib, pkgs, nix-openclaw, system,  ... }: {
  options.openBot.enable = lib.mkEnableOption "Enable openBot"
    // { default = false; };
  config = lib.mkIf config.openBot.enable {
    fileSystems."/var/lib/openclaw/workspace" = {
      device = "192.168.0.100:/mnt/Svartalfheim/OpenClaw";
      fsType = "nfs";
      options = [  ];
    };
    systemd.services."openclaw-gateway" = {
      description = "OpenClaw Gateway Daemon";
      after = [ "network.target" "remote-fs.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = "openclaw";
        WorkingDirectory = "/var/lib/openclaw";
        ExecStart = "${home-manager.outputs.packages.${system}.default}/bin/openclaw gateway --port 18789";
        Restart = "always";
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        ReadOnlyPaths = [ "/etc" "/var/log/journal" ];
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectKernelTunables = true;
        ProtectControlGroups = true;
        RestrictNamespaces = true;
        MemoryMax = "12G";
      };
    };
#    home-manager = lib.mkIf config.homeManager.enable {
#    #  useGlobalPkgs = true;
#    #  useUserPackages = true;
#      users.openclaw = { pkgs, ... }: {
#        imports = [ nix-openclaw.homeManagerModules.openclaw ];
#        programs.openclaw = {
#          enable = true;
#          package = pkgs.openclaw;  # or the latest from nix-openclaw
#          config = {
#            agent.model = "anthropic/claude-opus-4-5";  # or local ollama if you prefer
#            tools = {
#              profile = "minimal";           # only safe tools initially
#              deny = [ "group:automation" "group:runtime" "group:fs:write" "rm" "sudo" "apt" "mv" "cp" ];
#              exec = {
#                security = "ask";           # forces confirmation for any exec
#                safeBinProfiles = [ "read-only-diagnostics" ];
#              };
#            };
#            agents.defaults.sandbox = {
#              mode = "session";             # Docker-like isolation for non-main sessions
#              workspaceAccess = "ro";       # start read-only
#            };
#            dmPolicy = "pairing";           # you must approve the first chat
#          };
#          documents = {
#            "AGENTS.md" = pkgs.writeText "AGENTS.md" ''
#              You are a read-only homelab diagnostic assistant.
#              You have NO write or destructive permissions.
#              If a command would fail due to permissions, respond with the EXACT command the human (root) should run.
#              Never attempt rm, mv, apt, sudo, etc.
#            '';
#            "SOUL.md" = pkgs.writeText "SOUL.md" ''
#              You are helpful but extremely cautious. Always prefer suggesting commands over executing.
#            '';
#          };
#          instances.default = {
#            enable = true;
#            stateDir = "/var/lib/openclaw";
#            workspaceDir = "/var/lib/openclaw/workspace";
#          };
#        };
#      };
#    };
  };
}
