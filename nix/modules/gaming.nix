{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.gaming;
in {
  options.gaming = {
    enable = mkEnableOption "Gaming configuration for laptops";
    graphics = {
      nvidia = {
        enable = mkEnableOption "NVIDIA proprietary drivers";
        prime = {
          enable = mkEnableOption "NVIDIA PRIME for hybrid graphics";
          intelBusId = mkOption {
            type = types.str;
            default = "PCI:0:2:0";
            description = "PCI bus ID of the Intel GPU";
          };
          nvidiaBusId = mkOption {
            type = types.str;
            default = "PCI:1:0:0";
            description = "PCI bus ID of the NVIDIA GPU";
          };
        };
      };
    };
    programs.steam = mkIf cfg.steam.enable {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    lutris = {
      enable = mkEnableOption "Lutris game manager";
      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = "Additional packages to install for Lutris";
      };
    };
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional gaming-related packages to install";
    };
  };
  config = mkIf cfg.enable {
    boot = {
      kernelParams = [
        "quiet"
        "udev.log_priority=3"
      ] ++ (optionals (!cfg.graphics.nvidia.enable) [
        # AMD/Intel specific kernel parameters
        "amdgpu.ppfeaturemask=0xffffffff" # Enable all amdgpu features
      ]) ++ (optionals cfg.graphics.nvidia.enable [
        # NVIDIA specific kernel parameters
        "nvidia-drm.modeset=1"
      ]);
      kernelModules = [
        "amd_pstate"  # For AMD CPUs
      ] ++ (optionals (!cfg.graphics.nvidia.enable) [
        "amdgpu"
      ]) ++ (optionals cfg.graphics.nvidia.enable [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ]);
    };
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ] ++ (optionals (!cfg.graphics.nvidia.enable) [
          # AMD/Intel specific packages
          amdvlk
          rocm-opencl-icd
          rocm-opencl-runtime
        ]);
      };
      nvidia = mkIf cfg.graphics.nvidia.enable {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = mkIf cfg.graphics.nvidia.prime.enable {
          offload.enable = true;
          intelBusId = cfg.graphics.nvidia.prime.intelBusId;
          nvidiaBusId = cfg.graphics.nvidia.prime.nvidiaBusId;
        };
      };
    };
    environment.systemPackages = with pkgs; [
      gamemode
      mangohud
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      libstrangle
      gamescope
      htop
      s-tui
      antimicrox
    ] ++ (optionals cfg.steam.enable [
      steam
      steam-run
      protontricks
    ] ++ (optionals cfg.steam.protonGE [
      protonup-qt
    ])) ++ (optionals cfg.lutris.enable ([
      lutris
      wine
      winetricks
      wineWowPackages.stable
    ] ++ cfg.lutris.extraPackages)) ++ cfg.extraPackages;
    programs.steam = mkIf cfg.steam.enable {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    sound.enable = true;
    hardware.pulseaudio.support32Bit = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      # Low latency settings
      config.pipewire = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 32;
        };
      };
    };
    powerManagement.cpuFreqGovernor = "performance";
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [ 27036 27037 ]; # Steam
        allowedUDPPorts = [ 27031 27036 ]; # Steam
      };
      networkmanager.wifi.powersave = false;
    };
  };
}
