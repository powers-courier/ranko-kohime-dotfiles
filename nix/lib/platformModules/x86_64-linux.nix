{ cpuVendor ? "generic", lib, ... }:
[
  ({ pkgs, lib, ... }: {
    # Base x86_64 settings everyone gets
    boot.kernelPackages = pkgs.linuxPackages_latest;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  })
  (lib.mkIf (cpuVendor == "intel") {
    boot = {
      kernelModules = [ "kvm-intel" ];
      kernelParams = [ "intel_iommu=on" ];
    };
    hardware = {
      cpu.intel.updateMicrocode = true;
      intel-gpu-tools.enable = true;
    };
  })
  (lib.mkIf (cpuVendor == "amd") {
    cpuAmdOptimizations.enable = true;
    hardware.cpu.amd.updateMicrocode = true;
    boot = {
      kernelModules = [ "kvm-amd" ];
      kernelParams = [ "amd_iommu=on" ];
    };
  })
]
