{
  description = "Ranko Kohime's Flake v2";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:openclaw/nix-openclaw";
    nix-openclaw.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      vars = {
        loKale = "en_US.UTF-8";
        tailscale-fqdn = "manticore-elnath.ts.net";
        truenas-ip = "192.168.168.2";
      };
      hardwareConfigs = {
        framework-13 = {
          fileSystems = {
            "/" = {
              device = "zroot/root";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/F83E-8932";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
            "/home" = {
              device = "zroot/home";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/nix" = {
              device = "zroot/nix";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/var" = {
              device = "zroot/var";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
          };
          networking = {
            hostId = "af2f1b7f";
          };
          swapDevices = [ ];
          system.stateVersion = "25.05";
        };
        jelly-proxy-01 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/5803de2e-1612-469e-862f-acd51884606e";
              fsType = "ext4";
              options = [ "defaults" ];
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/7655-7B22";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        jelly-proxy-03 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/c1de1e73-2138-4286-888b-ef9b5d5b2eae";
              fsType = "ext4";
              options = [ "defaults" ];
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/5320-4C3E";
              fsType = "vfat";
              options = [ "fmask=0022" "dmask=0022" ];
            };
            "/Mounts/Music" = {
              device = "192.168.1.22:/mnt/tank2/Snapshotted/Music";
              fsType = "nfs";
              options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
            };
            "/Mounts/Videos" = {
              device = "192.168.1.22:/mnt/tank2/Snapshotted/Videos";
              fsType = "nfs";
              options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
            };
            "/Mounts/youtube-dl" = {
              device = "192.168.0.2:/mnt/youtube-dl/youtube-dl";
              fsType = "nfs";
              options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
            };
          };
        };
        jelly-proxy-04 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/8bfa1c39-f4c5-4b66-8a9e-db7b7b7cbb72";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/19A8-4887";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        jelly-proxy-05 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/f97df9e0-b2ac-4e29-84ba-12f27bd54b07";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/0283-E117";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        jelly-proxy-06 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/5395506b-3569-4992-8d36-bcbeee416cbd";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/2069-81C4";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        jelly-proxy-07 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/18687194-1d96-47af-b2ed-3bab9f7bf253";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/DFE8-3B70";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        main-host = {
          fileSystems = {
            "/" =
            { device = "zroot/root";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/nix" = {
              device = "zroot/nix";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/var" = {
              device = "zroot/var";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/home" = {
              device = "zroot/home";
              fsType = "zfs";
              options = [ "zfsutil" ];
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/A0D5-9779";
              fsType = "vfat";
              options = [ "fmask=0022" "dmask=0022" ];
            };
          };
          networking = {
            hostId = "2b7f3c3a";
          };
          system.stateVersion = "25.05";
        };
        n100 = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/3baf4636-0456-44fc-a48b-72fbb49cea3f";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/9BBB-EE1C";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
        openclaw = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/e2feb3c4-8705-40f5-a21b-91429d3e1bcd";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/B830-073C";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
            "/var/lib/openclaw/workspace" = {
              device = "${vars.truenas-ip}:/mnt/Svartalfheim/OpenClaw";
              fsType = "nfs";
              options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
            };
          };
          system.stateVersion = "25.05";
        };
        router-ask = {
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/3b3ab7cd-a88b-4023-ba13-b81e90ba7f99";
              fsType = "ext4";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/C515-66E7";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
        };
      };
      homeConfigurations = {
        
      };
      flakeModules = {
        defaultNetworking = { config, lib, ... }: {
          options.defaultNetworking = {
            enable = lib.mkEnableOption "Default network settings" // { default = true; };
            useIwd = lib.mkEnableOption "Enable IWD Wireless Client" // { default = true; };
          };
          config = lib.mkIf config.defaultNetworking.enable {
            networking = {
              networkmanager = {
                enable = true;
                wifi.backend = "iwd";
              };
              wireless.iwd = lib.mkIf config.defaultNetworking.useIwd {
                enable = lib.mkDefault true;
                settings = {
                  General = {
                    EnableNetworkConfiguration = true;
                  };
                  Network = {
                    EnableIPv6 = true;
                    RoutePriorityOffset = 300;
                  };
                  Settings = {
                    AutoConnect = true;
                  };
                };
              };
            };
          };
        };
        defaultSettings = { config, lib, ... }: {
          options.defaultSettings.enable = lib.mkEnableOption "Default system settings" // { default = true; };
          config = lib.mkIf config.defaultSettings.enable {
            hardware.enableRedistributableFirmware = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            nixpkgs.config.allowUnfree = true;
            time.timeZone = lib.mkDefault "Etc/UTC";
          };
        };
        desktopXFCE = { config, lib, pkgs, ... }: {
          options.desktopXFCE.enable = lib.mkEnableOption "XFCE Desktop" // { default = false; };
          config = lib.mkIf config.desktopXFCE.enable {
            environment.systemPackages = with pkgs; [
              thunar-volman
              ulauncher
            ];
            programs.firefox.enable = true;
            services = {
              displayManager = {
                autoLogin = {
                  enable = true;
                  user = "ranko";
                };
                defaultSession = "xfce";
              };
              xserver = {
                displayManager = {
                  lightdm.enable = true;
                };
                desktopManager.xfce.enable = true;
                enable = true;
                xkb = {
                  layout = "us";
                  variant = "";
                };
              };
            };
          };
        };
        disableWireless = { config, lib, pkgs, ... }:
        let
          cfg = config.security.disableWireless;
        in
        {
          options.security.disableWireless = with lib; {
            enable = mkEnableOption "forcibly disable all wireless connectivity (Wi-Fi, Bluetooth, WWAN, etc.)" // {
              default = false;
            };
          };
        
          config = lib.mkIf cfg.enable {
            networking.networkmanager = {
              enable = lib.mkDefault true;  # keep NM if used for wired, but kill wireless
              wifi.backend = lib.mkForce "none";
              wifi.scanRandMacAddress = false;
              wifi.powersave = false;
            };
            networking.wireless = {
              enable = lib.mkForce false;
              iwd.enable = lib.mkForce false;
            };
            hardware.bluetooth = {
              enable = lib.mkForce false;
              powerOnBoot = lib.mkForce false;
            };
            services.blueman.enable = lib.mkForce false;
            networking.modemmanager.enable = lib.mkForce false;
            services.udev.extraRules = ''
              ACTION=="add", SUBSYSTEM=="rfkill", ATTR{type}=="0|1|2", ATTR{soft}="1", RUN+="${pkgs.util-linux}/bin/rfkill block all"
              ACTION=="change", SUBSYSTEM=="rfkill", ATTR{type}=="0|1|2", ATTR{soft}="0", RUN+="${pkgs.util-linux}/bin/rfkill block all"
            '';
            boot.blacklistedKernelModules = [
              "ath10k_core"
              "ath10k_pci"
              "ath9k"
              "ath9k_htc"
              "b43"
              "bcma"
              "bluetooth"
              "brcmfmac"
              "brcmsmac"
              "btbcm"
              "btintel"
              "btrtl"
              "btusb"
              "cdc_mbim"
              "cdc_ncm"
              "iwlmvm"
              "iwlwifi"
              "iwlwifi_opregion"
              "mt7601u"
              "mt76x0u"
              "mt76x2u"
              "mt7921_common"
              "mt7921e"
              "mt7921u"
              "option"
              "qmi_wwan"
              "rtlwifi"
              "rtw88_core"
              "rtw88_pci"
              "usbserial"
            ];
             # This option does not exist
        #    boot.initrd.blacklistedKernelModules = config.boot.blacklistedKernelModules;
            environment.systemPackages = with pkgs; [
              bluez-tools  # even though bluetooth is off, useful for debugging
              iw
              util-linux   # for rfkill
            ];
            environment.etc."motd".text = lib.mkAfter ''
              NOTICE: Wireless (Wi-Fi / Bluetooth / WWAN) is forcibly disabled on this system.
            '';
          };
        };
        fancyKeyboards = { config, lib, pkgs, ... }: {
          options.fancyKeyboards.enable = lib.mkEnableOption "Configuration for fancy keyboards" // { default = false; };
          config = lib.mkIf config.fancyKeyboards.enable {
            environment.systemPackages = with pkgs; [
              system76-keyboard-configurator
            ];
            hardware.keyboard.zsa.enable = true;
          };
        };
        fwupdFirmware = { config, lib, ... }: {
          options.fwupdFirmware.enable = lib.mkEnableOption "Enable Firmware update daemon (fwupd)" // { default = true; };
          config = lib.mkIf config.fwupdFirmware.enable {
            services.fwupd = {
              daemonSettings = {
                IgnorePower = true;
              };
              enable = true;
        #      extraRemotes = [];
        #      uefiCapsuleSettings = {};
            };
          };
        };
        cpuAmdOptimizations = { config, lib, pkgs, ... }: {
          options.cpuAmdOptimizations.enable = lib.mkEnableOption "Optimizations for AMD Hardware" // { default = false; };
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
        };
        defaultNanoRC = { config, lib, programs, ... }: {
          options.defaultNanoRC.enable = lib.mkEnableOption "Sane defaults for nanorc" // { default = true; };
          config = lib.mkIf config.defaultNanoRC.enable {
            programs.nano = lib.mkForce {
              enable = true;
              nanorc = ''
                set autoindent
                set boldtext
                set constantshow
                set linenumbers
                set nowrap
                set smarthome
                set tabsize 2
                set tabstospaces
              '';
            };
          };
        };
        jellyfinProxyHost = { config, lib, pkgs, ... }: {
          options.jellyfinProxyHost.enable = lib.mkEnableOption "Enable proxy hosting for Jellyfin server" // { default = false; };
          config = lib.mkIf config.jellyfinProxyHost.enable {
            networking = {
              firewall = {
                enable = true;
                allowedTCPPorts = [ 8096 ];
                allowedUDPPorts = [ 5353 ];
              };
            };
            boot.kernel.sysctl = {
              "net.ipv4.ip_forward" = 1;
              "net.ipv6.conf.all.forwarding" = 1;
            };
            services.networkd-dispatcher = {
              enable = true;
              rules."50-tailscale" = {
                onState = [ "routable" ];
                script = ''
                  #!/usr/bin/env bash
                  ${pkgs.ethtool}/bin/ethtool -K enp1s0 rx-udp-gro-forwarding on rx-gro-list off
                '';
              };
            };
            services.tailscale = {
              enable = true;
              openFirewall = true;
            };
            services.nginx = {
              enable = true;
              virtualHosts."default" = {
                default = true;
                listen = [ { addr = "0.0.0.0"; port = 8096; } ];
                locations."/" = {
                  proxyPass = "http://main-host.${vars.tailscale-fqdn}:8096/";
                  extraConfig = ''
                    proxy_http_version 1.1;
                    proxy_set_header Host "main-host.${vars.tailscale-fqdn}";
                    proxy_set_header X-Real-IP $remote_addr;
                    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header X-Forwarded-Proto $scheme;
                    proxy_set_header Upgrade $http_upgrade;
                    proxy_set_header Connection "upgrade";
                  '';
                };
              };
            };
            services.avahi = {
              enable = true;
              nssmdns4 = true;
              publish = {
                enable = true;
                addresses = true;
                userServices = true;
              };
            };
            environment.etc."avahi/services/jellyfin.service".text = ''
              <?xml version="1.0" standalone='no'?>
              <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
              <service-group>
                <name>Jellyfin Proxy</name>
                <service>
                  <type>_http._tcp</type>
                  <port>8096</port>
                  <txt-record>description=Jellyfin Media Server Proxy</txt-record>
                </service>
              </service-group>
            '';
            environment.systemPackages = with pkgs; [
              avahi
              ethtool
              nginx
              tailscale
            ];
          };
        };
        jellyfinServer = { config, lib, pkgs, ... }: {
          options.jellyfinServer.enable = lib.mkEnableOption "Setup Jellyfin Server" // { default = false; };
          config = lib.mkIf config.jellyfinServer.enable {
            boot.kernelParams = [ "i915.enable_guc=2" ];
            nixpkgs.config.allowUnfree = true;
            hardware = {
              enableAllFirmware = true;
              graphics.enable = true;
            };
            services.jellyfin = {
              enable = true;
              group = "jellyfin";
              openFirewall = true;
              user = "jellyfin";
              dataDir = "/var/lib/jellyfin"; # Default data directory
              cacheDir = "/var/cache/jellyfin"; # Cache directory for transcoding
            };
            environment = {
              sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
              systemPackages = with pkgs; [
                intel-compute-runtime
                intel-gpu-tools
                intel-media-driver
                jellyfin-ffmpeg
                libva
                libva-utils
                libvdpau-va-gl
                vaapiVdpau
                vpl-gpu-rt
              ];
            };
            systemd.tmpfiles.rules = [
              "d ${config.services.jellyfin.cacheDir} 0750 jellyfin jellyfin - -"
            ];
            users.groups.jellyfin.members = [ "jellyfin" ];
            systemd.services.jellyfin = {
              after = [ "network.target" ];
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                Restart = "on-failure";
                RestartSec = 5;
              };
            };
          };
        };
        backupPackages = { config, lib, pkgs, ... }: {
          options.backupPackages.enable = lib.mkEnableOption "Install backup packages" // { default = true; };
          config = lib.mkIf config.backupPackages.enable {
            environment.systemPackages = with pkgs; [
              dar
              ddrescue
              par2cmdline
              unison
            ];
          };
        };
        basePackages = { config, lib, pkgs, ... }: {
          options.basePackages.enable = lib.mkEnableOption "Install standard packages" // { default = true; };
          config = lib.mkIf config.basePackages.enable {
            environment.systemPackages = with pkgs; [
              byobu
              dmidecode
              git
              glances
              linux-firmware
              lm_sensors
              neovim
              socat
              sshfs
              tmux
              tree
              yazi
            ];
          };
        };
        defaultBootloader = { config, lib, ... }: {
          options.defaultBootloader.enable = lib.mkEnableOption "Set default bootloader" // { default = true; };
          config = lib.mkIf config.defaultBootloader.enable {
            boot = {
              initrd.availableKernelModules = [ "ahci" "nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci" ];
              loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
              };
            };
          };
        };
        cpuLimiterIntel = { config, lib, ... }: {
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
        };
        lokale = { config, lib, ... }: {
          options.lokale.enable = lib.mkEnableOption "Set Locale" // { default = true; };
          config = lib.mkIf config.lokale.enable {
            i18n = {
              defaultLocale = vars.loKale;
              extraLocaleSettings = {
                LC_ADDRESS = vars.loKale;
                LC_IDENTIFICATION = vars.loKale;
                LC_MEASUREMENT = vars.loKale;
                LC_MONETARY = vars.loKale;
                LC_NAME = vars.loKale;
                LC_NUMERIC = vars.loKale;
                LC_PAPER = vars.loKale;
                LC_TELEPHONE = vars.loKale;
                LC_TIME = vars.loKale;
              };
            };
          };
        };
        userJellyfin = { ... }: {
          users = {
            groups.jellyfin = {
              gid = 8096;
              name = "jellyfin";
            };
            users.jellyfin = {
              extraGroups = [ "render" "video" ];
              group = "jellyfin";
              isNormalUser = true;
              isSystemUser = lib.mkForce false;
              uid = 8096;
            };
          };
        };
        userRanko = { ... }: {
          users.users.ranko = {
            isNormalUser = true;
            description = "Ranko Kohime";
            extraGroups = [ "jellyfin" "networkmanager" "video" "wheel" ];
            uid = 1000;
          };
        };
        zfsBootOptions = { config, lib, ... }: {
          options.zfsBootOptions.enable = lib.mkEnableOption "Boot settings for root on ZFS hosts" // { default = false; };
          config = lib.mkIf config.zfsBootOptions.enable {
            boot = {
              loader = {
                grub.enable = false;
              };
              supportedFilesystems = [ "zfs" ];
              zfs.forceImportRoot = false;
            };
            zfsOptions.enable = true;
            zfsSanoid.enable = true;
          };
        };
        zfsOptions = { config, lib, ... }: {
          options.zfsOptions.enable = lib.mkEnableOption "Common settings for ZFS pools" // { default = false; };
          config = lib.mkIf config.zfsOptions.enable {
            boot.kernelParams = [ "zfs.zfs_arc_max=1073741824" ];
            services = {
              zfs = {
                autoScrub = {
                  enable = true;
                  interval = "monthly";
                  pools = [ "zroot" ];
                };
                trim.enable = true;
              };
            };
          };
        };
        zfsSanoid = { config, lib, ... }: {
          options.zfsSanoid.enable = lib.mkEnableOption "Enable Sanoid/Syncoid for ZFS" // { default = false; };
          config = lib.mkIf config.zfsSanoid.enable {
            services = {
              sanoid = {
                enable = true;
              };
              syncoid = {
                enable = true;
              };
        zramSwap = { config, lib, ... }: {
          options.dangerSwap.enable = lib.mkEnableOption "Enable zram compressed swap" // { default = true; };
          config = lib.mkIf config.dangerSwap.enable {
            zramSwap = {
              enable = true;
              priority = 1;
              memoryPercent = 100;
              swapDevices = 1;
            };
          };
        };
      };
      autoModules = let
        dir = ./modules;
        entries = builtins.readDir dir;
        nixFiles = builtins.filter
          (name: builtins.match ".*\\.nix" name != null)
          (builtins.attrNames entries);
      in builtins.listToAttrs (builtins.map
        (name: {
          name = builtins.replaceStrings [".nix"] [""] name;  # e.g. "backupPackages"
          value = import (dir + "/${name}");
        })
        nixFiles);
      jellyProxyHosts = builtins.filter
        (name: lib.hasPrefix "jelly-proxy-" name)
        (lib.attrNames hardwareConfigs);
      Jelly-Proxy-Configs = lib.listToAttrs (map (name: {
        inherit name;
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = lib.flatten [
            hardwareConfigs.${name}
            (builtins.attrValues flakeModules)
            ({ ... }: {
              networking = {
                hostName = name;
              };
              system.stateVersion = "25.05";
              cpuLimiterIntel.enable = true;
              jellyfinProxyHost.enable = true;
            })
          ];
        };
      }) jellyProxyHosts);
      platformModules = {
        # Called with { system = "x86_64-linux"; cpuVendor = "intel"; } or similar
        x86_64-linux = { cpuVendor ? "generic", ... }: [
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
              acpilight.enable = true;
              cpu.intel = {
                updateMicrocode = true;
              };
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
        ];
        aarch64-linux = { cpuVendor ? "generic", ... }: [
          ({ pkgs, ... }: {
            # Base arm64 settings
            boot.kernelPackages = pkgs.linuxPackages_latest;
            # e.g. better handling of big.LITTLE if needed, etc.
          })
          (lib.mkIf (cpuVendor == "apple") {
            # Apple Silicon (asahi or similar)
            hardware.asahi.enable = true;   # example
            # or your custom apple tweaks
          })
          (lib.mkIf (cpuVendor == "rockchip") {
            # e.g. RK3588, Orange Pi 5, etc.
            boot.kernelParams = [ "coherent_pool=1M" ];
          })
        ];
      };
      mkHost = {
        hostname,
        system ? "x86_64-linux",
        cpuVendor ? "generic",
        role ? "desktop",
        extraModules ? [],
        specialArgs ? {},
      } @ args:
        let
          selectedPlatformModules =
            platformModules.${system} or
              (throw "Unsupported system: ${system}");
          platformModuleList = selectedPlatformModules {
            inherit system cpuVendor;
            inherit (args) hostname;   # if needed inside
          };
          roleModules = {
            desktop = { pkgs, ... }: {
              fancyKeyboards.enable = true;
              # GUI, sound, printing, etc.
              services.xserver.enable = true;
              services.pulseaudio.enable = false;  # or pipewire
              services.pipewire = {
                enable = true;
                alsa.enable = true;
                pulse.enable = true;
              };
            
              # Common desktop packages
              environment.systemPackages = with pkgs; [
                firefox libreoffice-fresh vlc
                # ... your usual suspects
              ];
            
              # Power management suitable for laptops/desktops
              powerManagement.enable = true;
              services.tlp.enable = true;  # or auto-cpufreq, etc.
            };
            laptop = { pkgs, ... }: {
              imports = [ roleModules.desktop ];
              environment.systemPackages = with pkgs; [
                byobu # Just to have non-empty list
              ];
              powerManagement = {
                cpuFreqGovernor = lib.mkDefault "powersave";
                powertop.enable = true;
              };
            };
            minimal = { ... }: {
              environment.systemPackages = lib.mkForce [];
            };
            router = { ... }: {
              my-router.enable = true;
            };
            server = { lib, pkgs, ... }: {
              # Disable anything graphical or wireless
              security.disableWireless.enable = true;   # your new module
              boot.kernelParams = [ "quiet" "splash" ]; # less verbose boot
            
              # No X/Wayland
              services.xserver.enable = lib.mkForce false;
            
              # Common server hardening
              networking.firewall.enable = true;
            
              # Minimal packages
              environment.systemPackages = with pkgs; [
                htop tmux git
              ];
            
              # Disable unnecessary services
              services.printing.enable = lib.mkForce false;
              hardware.bluetooth.enable = lib.mkForce false;
              networking.networkmanager.enable = lib.mkForce false;  # usually no NM on servers
            };
            # Future roles (placeholders)
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = args.specialArgs // { inherit vars; };
          modules = lib.flatten [
            hardwareConfigs.${hostname}
            platformModuleList
            (builtins.attrValues flakeModules)
            (builtins.attrValues autoModules)
            {
              networking.hostName = hostname;
            }
            (roleModules.${role} or (throw "No role module defined for '${role}'"))
          ] ++ extraModules;
        };
    in
    rec {
      nixosModules = flakeModules;
      homeConfigurations = {
        
      };
      nixosConfigurations = Jelly-Proxy-Configs // {
        framework-13 = mkHost {
          hostname = "framework-13";
          system = "x86_64-linux";
          cpuVendor = "intel";
          role = "laptop";
          extraModules = [
            { desktopXFCE.enable = true; }
            { zfsBootOptions.enable = true; }
          ];
        };
        router-ask = mkHost {
          hostname = "router-ask";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            { flakey-router.enable = true; }
          ];
        };
        main-host = mkHost {
          hostname = "main-host";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            { jellyfinServer.enable = true; }
            { zfsBootOptions.enable = true; }
            {
              networking = {
                interfaces = {
                  enp4s0 = {
                    ipv4.addresses = [{
                      address = "192.168.168.25";
                      prefixLength = 24;
                    }];
                    mtu = 9000;
                  };
                };
              };
            }
          ];
        };
        openclaw = mkHost {
          hostname = "openclaw";
          system = "x86_64-linux";
          cpuVendor = "intel";
          role = "server";
          extraModules = [
            { openBot.enable = true; }
          ];
          specialArgs = { inherit (inputs) nix-openclaw; };
        };
      };
      images = {
        
      };
    };
}
