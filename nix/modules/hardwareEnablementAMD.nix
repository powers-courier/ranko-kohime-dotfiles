{ config, lib, pkgs, ... }: {
  options.cpuAmdOptimizations.enable = lib.mkEnableOption "Optimizations for AMD Hardware" //
    { default = false; };
  config = lib.mkIf config.cpuAmdOptimizations.enable {
    boot = {
      extraModprobeConfig = ''
        options iwlwifi power_save=1
      '';
      kernelParams = [
        "acpi_backlight=vendor"
        "acpi_osi=!"
        "amd_pstate=guided"
        "amdgpu.abmlevel=0"
        "amdgpu.backlight=0"
        "amdgpu.dcdebugmask=0x10"
        "amdgpu.runpm=1"
        "mem_sleep_default=s2idle"
        "nvme.noacpi=1"
        "nvme_core.default_ps_max_latency_us=0"
        "pcie_aspm.policy=powersave"
      ];
    };
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    powerManagement.powertop.enable = true;
    services = {
      power-profiles-daemon.enable = true;
      tlp.enable = false;
    };
    systemd.settings.Manager = {
      DefaultTimeoutStopSec = "90s";
    };
  };
}
