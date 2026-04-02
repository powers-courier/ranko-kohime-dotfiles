{ config, lib, ... }: {
  options.cpuLimiterIntel.enable = lib.mkEnableOption "Set CPU Limiter on boot for Intel" // { default = false; };
  config = lib.mkIf config.cpuLimiterIntel.enable {
    systemd.services.limit-cpu-max-perf = {
      description = "Limit CPU max performance percentage using intel_pstate";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          /run/current-system/sw/bin/sh -c "echo 1 > /sys/devices/system/cpu/intel_pstate/max_perf_pct"
        '';
        RemainAfterExit = true;
      };
    };
  };
}
