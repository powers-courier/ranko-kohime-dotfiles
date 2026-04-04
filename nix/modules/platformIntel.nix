{ config, lib, pkgs, ... }: {
  options.platformModuleIntel.enable = lib.mkEnableOption "Intel CPU-specific optimizations, KVM, microcode, and tools"
    // { default = false; };
  config = lib.mkIf config.platformModuleIntel.enable {
    boot = {
      kernelModules = [ "kvm-intel" ];
      kernelParams = [ "intel_iommu=on" ];
    };
    hardware = {
      cpu.intel.updateMicrocode = true;
      intel-gpu-tools.enable = true;
    };
  };
}
