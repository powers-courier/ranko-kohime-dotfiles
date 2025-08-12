{ config, lib, ... }:
with lib;
let
  cfg = config.services.limitCpuMaxPerf;
  # Architecture-specific implementations
  archImplementations = {
    amd = {
      description = "Limit CPU max performance percentage for AMD processors";
      path = "/sys/devices/system/cpu/amd_pstate/max_perf_pct";
      checkCommand = ''
        if [ ! -d "/sys/devices/system/cpu/amd_pstate" ]; then
          echo "AMD pstate driver not available" >&2
          exit 1
        fi
      '';
    };
    arm = {
      description = "Limit CPU max performance percentage for ARM processors";
      path = "/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq";
      checkCommand = ''
        if [ ! -f "/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq" ]; then
          echo "ARM CPU frequency scaling not available" >&2
          exit 1
        fi
        # For ARM, we need to get the maximum frequency first
        MAX_FREQ=$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq)
      '';
      # ARM requires a different approach - calculate frequency from percentage
      writeCommand = percentage: ''
        MAX_FREQ=$(cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq)
        TARGET_FREQ=$(( $MAX_FREQ * ${toString percentage} / 100 ))
        echo $TARGET_FREQ > ${archImplementations.arm.path}
      '';
    };
    intel = {
      description = "Limit CPU max performance percentage using intel_pstate";
      path = "/sys/devices/system/cpu/intel_pstate/max_perf_pct";
      checkCommand = ''
        if [ ! -d "/sys/devices/system/cpu/intel_pstate" ]; then
          echo "Intel pstate driver not available" >&2
          exit 1
        fi
      '';
    };
  };
in {
  options.services.limitCpuMaxPerf = {
    enable = mkEnableOption "CPU maximum performance limiting service";
    architecture = mkOption {
      type = types.enum [ "intel" "amd" "arm" "auto" ];
      default = "auto";
      description = "CPU architecture to target";
      example = "intel";
    };
    performancePercentage = mkOption {
      type = types.int;
      default = 80;
      description = "Maximum CPU performance percentage (1-100)";
      example = 50;
    };
    applyAtBoot = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to apply the limit at system boot";
    };
  };
  config = mkIf cfg.enable {
    systemd.services.limit-cpu-max-perf = {
      description = "Limit CPU max performance percentage";
      wantedBy = mkIf cfg.applyAtBoot [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = let
          # Ensure percentage is within valid range
          percentage = max 1 (min 100 cfg.performancePercentage);
          # Auto-detect architecture if set to auto
          autoDetectScript = ''
            if [ -d "/sys/devices/system/cpu/intel_pstate" ]; then
              ARCH="intel"
            elif [ -d "/sys/devices/system/cpu/amd_pstate" ]; then
              ARCH="amd"
            elif [ -f "/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq" ]; then
              ARCH="arm"
            else
              echo "Could not auto-detect CPU architecture" >&2
              exit 1
            fi
          '';
          # Create the script based on architecture
          script = if cfg.architecture == "auto" then ''
            #!/bin/sh
            # Auto-detect architecture
            ${autoDetectScript}
            # Apply based on detected architecture
            case "$ARCH" in
              intel)
                ${archImplementations.intel.checkCommand}
                echo ${toString percentage} > ${archImplementations.intel.path}
                ;;
              amd)
                ${archImplementations.amd.checkCommand}
                echo ${toString percentage} > ${archImplementations.amd.path}
                ;;
              arm)
                ${archImplementations.arm.checkCommand}
                ${archImplementations.arm.writeCommand percentage}
                ;;
            esac
          '' else ''
            #!/bin/sh
            # Apply for specific architecture: ${cfg.architecture}
            ${archImplementations.${cfg.architecture}.checkCommand}
            ${if cfg.architecture == "arm" 
              then archImplementations.arm.writeCommand percentage
              else "echo ${toString percentage} > ${archImplementations.${cfg.architecture}.path}"}
          '';
        in
          pkgs.writeShellScript "limit-cpu-perf.sh" script;
        RemainAfterExit = true;
      };
    };
  };
}
