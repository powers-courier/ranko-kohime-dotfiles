{ config, pkgs, lib, ... }: {
  networking.hostName = "sleipnir";
  boot = {
    blacklistedKernelModules = [
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia_uvm"
      "nouveau"
    ];
    initrd.kernelModules = [ "amdgpu" ];
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.systemPackages = with pkgs; [ ryzenadj ];
  systemd.services.apu-tdp-limit = {
    description = "Set AMD APU power limit to 15W";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    script = ''
      sleep 5
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
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  system.stateVersion = "25.05";
}
