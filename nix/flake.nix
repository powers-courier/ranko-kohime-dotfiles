{
  description = "Ranko Kohime's Flake v2";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      vars = {
        loKale = "en_US.UTF-8";
        timeZern = "Etc/UTC";
        tailscale-fqdn = "manticore-elnath.ts.net";
        truenas-ip = "192.168.168.2";
      };
      hardwareConfigs = {
        framework-13 = {
          fileSystems = {
            "/" = {
              device = "zroot/root";
              fsType = "zfs";
            };
            "/boot" = {
              device = "/dev/disk/by-uuid/F83E-8932";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
            "/home" = {
              device = "zroot/home";
              fsType = "zfs";
            };
            "/nix" = {
              device = "zroot/nix";
              fsType = "zfs";
            };
            "/var" = {
              device = "zroot/var";
              fsType = "zfs";
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
        jelly-proxy-02 = {
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
            };
            "/nix" = {
              device = "zroot/nix";
              fsType = "zfs";
            };
            "/var" = {
              device = "zroot/var";
              fsType = "zfs";
            };
            "/home" = {
              device = "zroot/home";
              fsType = "zfs";
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
      };
      flakeModules = {
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
              lm_sensors
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
            boot.loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
          };
        };
        defaultSettings = { config, lib, ... }: {
          options.defaultSettings.enable = lib.mkEnableOption "Default system settings" // { default = true; };
          config = lib.mkIf config.defaultSettings.enable {
            networking.networkmanager.enable = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
            programs.nano.nanorc = ''
              set autoindent
              set boldtext
              set constantshow
              set linenumbers
              set nowrap
              set smarthome
              set tabsize 2
              set tabstospaces
            '';
            time.timeZone = vars.timeZern;
          };
        };
        fwupd = { config, lib, ... }: {
          options.fwupd.enable = lib.mkEnableOption "Enable Firmware update daemon (fwupd)" // { default = true; };
          config = lib.mkIf config.fwupd.enable {
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
        glancesServer = { config, lib, pkgs, ... }: {
          options.glancesServer.enable = lib.mkEnableOption "Enable Glances service" // { default = true; };
          config = lib.mkIf config.glancesServer.enable {
            systemd.services.glances-server = {
              description = "Glances server";
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" ];
              serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.glances}/bin/glances -w";
                RemainAfterExit = false;
                Restart = "always";
              };
            };
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
        opensshServer = { config, lib, ... }: {
          options.openssh.enable = lib.mkEnableOption "Enable OpenSSH server, and Mosh" // { default = true; };
          config = lib.mkIf config.openssh.enable {
            services.openssh = {
              banner = "Welcome to... wherever you happen to be\n";
              enable = true;
              extraConfig ="";
              openFirewall = true;
              ports = [ 22 ];
              settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "prohibit-password";
                PrintMotd = true;
                StrictModes = true;
                X11Forwarding = true;
              };
            };
            programs.mosh.enable = true;
          };
        };
        tailscaleVPN = { config, lib, ... }: {
          options.tailscale.enable = lib.mkEnableOption "Enable Tailscale VPN" // { default = true; };
          config = lib.mkIf config.tailscale.enable {
            services.tailscale = {
              enable = true;
              openFirewall = true;
              port = 0;
            };
          };
        };
        yubikey = { config, lib, pkgs, ... }: {
          options.yubikey-mod.enable = lib.mkEnableOption "Enable settings for Yubikeys" // { default = true; };
          config = lib.mkIf config.yubikey-mod.enable {
            environment.systemPackages = with pkgs; [
              libfido2
              pam_u2f
              yubico-piv-tool
              yubikey-agent
              yubikey-manager
              yubikey-personalization
              yubikey-touch-detector
            ];
            services.yubikey-agent.enable = true;
            programs.yubikey-touch-detector.enable = true;
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
            };
          };
        };
        zramSwap = { config, lib, ... }: {
          options.zramswap.enable = lib.mkEnableOption "Enable zram compressed swap" // { default = true; };
          config = lib.mkIf config.zramswap.enable {
            zramSwap = {
              enable = true;
              priority = 1;
              memoryPercent = 100;
              swapDevices = 1;
            };
          };
        };
      };
      proxyCount = 7;
      Jelly-Proxy-Configs = builtins.listToAttrs (map (i: let
        num = if i < 9 then "0${toString (i + 1)}" else toString (i + 1);
        name = "jelly-proxy-${num}";
      in {
        inherit name;
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            hardwareConfigs.${name}
            #flakeModules.cpuLimiter
            flakeModules.defaultBootloader
            flakeModules.defaultSettings
            ({ pkgs, vars, ... }: {
              networking.hostName = name;
              system.stateVersion = "25.05";
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
            })
          ];
        };
      }) (builtins.genList (i: i) proxyCount));
      platformModules = {
        # Called with { system = "x86_64-linux"; cpuVendor = "intel"; } or similar
        x86_64-linux = { cpuVendor ? "generic", ... }: [
          ({ config, pkgs, lib, ... }: {
            # Base x86_64 settings everyone gets
            boot.kernelPackages = pkgs.linuxPackages_latest;
          })
      
          (lib.mkIf (cpuVendor == "intel") {
            # Intel-specific
            hardware = {
              cpu.intel = {
                updateMicrocode = true;
              };
              intel-gpu-tools.enable = true;
            };
            boot.kernelParams = [ "intel_iommu=on" ];
          })
      
          (lib.mkIf (cpuVendor == "amd") {
            # AMD-specific
            hardware.cpu.amd.updateMicrocode = true;
            boot.kernelParams = [ "amd_iommu=on" ];
          })
        ];
      
        aarch64-linux = { cpuVendor ? "generic", ... }: [
          ({ config, pkgs, lib, ... }: {
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
        system ? "x86_64-linux",          # required or default
        cpuVendor ? "generic",            # intel, amd, apple, qualcomm, rockchip, ...
        extraModules ? [],                # host-specific stuff
      }@args:
      
        let
          # Select the right platform-specific module list
          selectedPlatformModules =
            platformModules.${system} or
              (throw "Unsupported system: ${system}");
      
          platformModuleList = selectedPlatformModules {
            inherit system cpuVendor;
            inherit (args) hostname;   # if needed inside
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
      
          modules = lib.flatten [
            hardwareConfigs.${hostname}
            platformModuleList
            (builtins.attrValues flakeModules)
            # Always set hostname (can be overridden later)
            {
              networking.hostName = hostname;
            }
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
          extraModules = [
            { fancyKeyboards.enable = true; }
            { zfsBootOptions.enable = true; }
          ];
        };
        main-host = mkHost {
          hostname = "main-host";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            { zfsBootOptions.enable = true; }
              ({
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
            })
          ];
        };
      };
      images = {
        
      };
    };
}
