{ config, pkgs, lib, ... }: {
  # ============================================
  # Basic System Configuration
  # ============================================

  networking.hostName = "sleipnir";

  # ============================================
  # GPU Configuration - AMD Only
  # ============================================

  # Option 1: Simple blacklist approach (RECOMMENDED)
  # This prevents Nvidia drivers from loading, system uses AMD GPU only
  boot.blacklistedKernelModules = [ 
    "nvidia" 
    "nvidia_drm" 
    "nvidia_modeset" 
    "nvidia_uvm"
    "nouveau"  # Also blacklist the open-source Nvidia driver
  ];

  # Ensure AMD GPU drivers are available
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable graphics with AMD drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Enable 32-bit support for compatibility
  };

  # DO NOT include "nvidia" in video drivers
  # Only specify video drivers if you need specific configuration
  # By default, AMD drivers will be used automatically
  # services.xserver.videoDrivers = [ "amdgpu" ];  # Usually not necessary

  # ============================================
  # Optional: Verify Nvidia is disabled
  # ============================================

  # This kernel parameter explicitly disables the Nvidia GPU at boot
  # (Alternative/additional method)
  # boot.kernelParams = [ "module_blacklist=nvidia,nvidia_drm,nvidia_modeset" ];

  # ============================================
  # System Information
  # ============================================

  # For reference: Your laptop specs
  # CPU: AMD Ryzen 9 7940HS (with integrated Radeon 780M graphics)
  # dGPU: NVIDIA GeForce RTX 4060 (will be disabled)
  # Display: 14" 2560x1600 165Hz

 # Install RyzenAdj
  environment.systemPackages = with pkgs; [ ryzenadj ];

  # Create script to apply TDP limit
  systemd.services.apu-tdp-limit = {
    description = "Set AMD APU power limit to 15W";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];

    script = ''
      # Wait for system to be ready
      sleep 5

      # Apply 15W limit (values in milliwatts)
      ${pkgs.ryzenadj}/bin/ryzenadj \
        --stapm-limit=15000 \
        --fast-limit=15000 \
        --slow-limit=15000 \
        --tctl-temp=85 || true
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # Use powersave governor for battery life
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  system.stateVersion = "25.05";
}
