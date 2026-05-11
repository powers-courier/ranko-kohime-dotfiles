{ cpuVendor ? "generic", lib, ... }: [
  ({ pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  })
  (lib.mkIf (cpuVendor == "apple") {
    hardware.asahi.enable = true;
  })
  (lib.mkIf (cpuVendor == "rockchip") {
    boot.kernelParams = [ "coherent_pool=1M" ];
  })
]
