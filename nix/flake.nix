{
  description = "Ranko Kohime's Flake, now with 100% more ZFS!";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { self, nixpkgs, hardware, home-manager, ... }@inputs:
  let
    vars = {
      loKale = "en_US.UTF-8";
      vaultKeyFragments = [
        ""
        ""
      ];
      timeZern = "Etc/UTC";
      tailscale-fqdn = "manticore-elnath.ts.net";
      truenas-ip = "192.168.168.2";
    };
    lib = nixpkgs.lib;
    hardwareConfigs = {
      framework-7840u = {
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
        swapDevices = [ ];
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
          "/Mounts/youtube-dl/z.DownloadTemp" = {
            device = "192.168.1.22:/mnt/tank2/Snapless/Workspace/ytdl-temp";
            fsType = "nfs";
            options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
          };
        };
      
        environment.etc."opt/shell.nix" = {
          text = ''
            { pkgs ? import <nixpkgs> {} }:
            pkgs.mkShell {
              buildInputs = with pkgs; [
                ffmpeg-full
                python3
                sshfs
              ];
            }
          '';
          mode = "0444";
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
    modules = {
      autoUpgrade = { config, lib, ... }: {
        options.autoUpgrade.enable = lib.mkEnableOption "Enable automatic upgrades from flake Git repo" // {default = false; };
        config = lib.mkIf config.autoUpgrade.enable {
          system.autoUpgrade = {
            enable = true;
            flake = "git+https://github.com/your/repo?ref=main";
            dates = "weekly";
            allowReboot = false; # Optional: avoid reboots
          };
        };
      };
      basePackages = { config, lib, pkgs, ... }: {
        options.basePackages.enable = lib.mkEnableOption "Install standard packages" // { default = true; };
        config = lib.mkIf config.basePackages.enable {
          environment.systemPackages = with pkgs; [
            byobu
            dar
            git
            glances
            sshfs
            tmux
            tree
            unison
          ];
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
      garbageCollection = { config, lib, ... }: {
        options.garbageCollection.enable = lib.mkEnableOption "Enable garbage collection in the Nix store, set to a conservative default" // { default = true; };
        config = lib.mkIf config.garbageCollection.enable {
          nix.gc = {
            automatic = true;
            dates = "monthly";
            options = "--delete-older-than 365d";
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
      nanorc = { config, lib, ... }: {
        options.nanorc.enable = lib.mkEnableOption "Enable system-wide nanorc configuration" // { default = true; };
        config = lib.mkIf config.nanorc.enable {
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
        };
      };
      openssh = { config, lib, ... }: {
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
      systemBlocks = { config, lib, pkgs, system, ... }: {
        config = {
          boot = lib.mkIf (system == "x86_64-linux") {
            extraModulePackages = [ ];
            initrd = {
              availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
              kernelModules = [ ];
            };
            kernelModules = [
              "kvm-amd"
              "kvm-intel"
            ];
            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
          };
          environment.systemPackages = lib.mkIf (system == "x86_64-linux") (with pkgs; [
            dmidecode
            lm_sensors
            ryzenadj
            ryzen-monitor-ng
          ]) ++ lib.mkIf (system == "aarch64-linux") (with pkgs; [
            rpi-tools
          ]);
          hardware = lib.mkIf (system == "x86_64-linux") {
            cpu = {
              amd = {
                ryzen-smu.enable = true;
                updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
              };
              intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            };
            intel-gpu-tools.enable = true;
          };
        };
      };
      tailscale = { config, lib, ... }: {
        options.tailscale.enable = lib.mkEnableOption "Enable Tailscale VPN" // { default = true; };
        config = lib.mkIf config.tailscale.enable {
          services.tailscale = {
            enable = true;
            openFirewall = true;
            port = 0;
          };
        };
      };
      zramswap = { config, lib, ... }: {
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
      user = { config, lib, ... }: {
        options.user = {
          ranko.enable = lib.mkEnableOption "Enable ranko user" // { default = true; };
          jellyfin.enable = lib.mkEnableOption "Enable jellyfin user";
        };
        config = {
          users = {
            groups = {
              docker = lib.mkIf config.virtualisation.docker.enable {};
              jellyfin = lib.mkIf config.user.jellyfin.enable {
                gid = 8096;
                name = "jellyfin";
              };
              users.gid = 100;
            };
            users.jellyfin = lib.mkIf config.user.jellyfin.enable {
              extraGroups = [ "render" "video" ];
              group = "jellyfin";
              isNormalUser = true;
              isSystemUser = lib.mkForce false;
              uid = 8096;
              gid = 8096;
            };
            users.ranko = lib.mkIf config.user.ranko.enable {
              isNormalUser = true;
              description = "Ranko Kohime";
              uid = 1000;
              group = "users";
              extraGroups = [ "networkmanager" "wheel" ]
                ++ lib.optionals config.user.jellyfin.enable [ "jellyfin" ]
                ++ lib.optionals (lib.attrByPath [ "virtualisation" "docker" "enable" ] false config) [ "docker" ];
            };
          };
        };
      };
    };
    baseConfig = { system, ... }: {
      networking.networkmanager.enable = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.hostPlatform = lib.mkDefault system;
      time.timeZone = vars.timeZern;
    };
    mkSystem = hostname: system: extraModules: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit vars; };
      modules = [
        baseConfig
        modules.autoUpgrade
        modules.basePackages
        modules.fwupd
        modules.garbageCollection
        modules.glancesServer
        modules.lokale
        modules.nanorc
        modules.openssh
        modules.systemBlocks
        modules.tailscale
        modules.user
        modules.zramswap
        { networking.hostName = hostname; }
        hardwareConfigs.${hostname}
      ] ++ extraModules;
    };
    proxyCount = 7;
    Jelly-Proxy-Configs = builtins.listToAttrs (map (i: let
      num = if i < 9 then "0${toString (i + 1)}" else toString (i + 1);
      name = "jelly-proxy-${num}";
    in {
      inherit name;
      value = mkSystem name "x86_64-linux" [
        ({ config, lib, ... }: {
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
        })
        ({ pkgs, vars, ... }: {
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
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            (writeScriptBin "rw" ''
              #!/usr/bin/env bash
              mount -o remount,rw /
              mount -o remount,rw /boot
              echo "Filesystem is now read-write"
            '')
            (writeScriptBin "ro" ''
              #!/usr/bin/env bash
              sync
              mount -o remount,ro /
              mount -o remount,ro /boot
              echo "Filesystem is now read-only"
            '')
          ];
        })
      ];
    }) (builtins.genList (i: i) proxyCount));
    mkGlancesService = hostname: {
      "Glances ${hostname}" = {
        href = "http://${hostname}.${vars.tailscale-fqdn}:61208/";
        description = "Glances";
        icon = "si-iterm2";
        widget = {
          type = "glances";
          url = "http://${hostname}.${vars.tailscale-fqdn}:61208/";
          version = 4;
          metric = "info";
          refreshInterval = 5000;
        };
      };
    };
    proxyHosts = map (i: "jelly-proxy-${lib.fixedWidthNumber 2 i}") (lib.range 1 proxyCount);
    proxyServices = map (host: mkGlancesService host) proxyHosts;
  in
    rec {
      homeConfigurations = {
        
      };
      nixosConfigurations = Jelly-Proxy-Configs // {
        main-host = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            hardwareConfigs.main-host
            ({ pkgs, vars, ... }: {
              boot = {
                supportedFilesystems = [ "zfs" ];
                zfs.forceImportRoot = false;
              };
              boot.kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
              
              services = {
                sanoid = {
                  enable = true;
                };
                syncoid = {
                  enable = true;
                };
                zfs = {
                  autoScrub = {
                    enable = true;
                    interval = "monthly";
                    pools = [ "zroot" ];
                  };
                  trim.enable = true;
                };
              };
              networking = {
                hostId = "2b7f3c3a";
                hostName = "main-host";
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
              networking = {
                domain = "midgard";
                firewall.allowedTCPPorts = [ 2049 ];
              };
              services = {
                nfs.idmapd = {
                  settings = {
                    General = {
                      Domain = "midgard";
                    };
                  };
                };
                rpcbind.enable = true;
              };
              fileSystems = {
                "/Mounts/Disks" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Disks";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Documents" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Documents";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Downloads" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Downloads";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/LGC_Actual" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/LGC_Actual";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/LGC_Lore_Table" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/LGC_Lore_Table";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Library" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Library";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Workspace" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Workspace";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
              };
              fileSystems = {
                "/Mounts/JellyConfig" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Videos/JellyConfig";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Music" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Music";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/Videos" = {
                  device = "${vars.truenas-ip}:/mnt/Svartalfheim/Videos";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/youtube-dl" = {
                  device = "${vars.truenas-ip}:/mnt/youtube-dl/youtube-dl";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
                "/Mounts/youtube-dl/z.Daily/Finished" = {
                  device = "${vars.truenas-ip}:/mnt/ytdl-fin/Finished";
                  fsType = "nfs";
                  options = [ "nfsvers=4" "hard" "users" "rw" "exec" "rsize=1048576" "wsize=1048576" ];
                };
              };
              system.stateVersion = "25.05";
              environment.systemPackages = with pkgs; [
                flac
                gimp3-with-plugins
                handbrake
                libmediainfo
                mediainfo
                mkvtoolnix
                python312Packages.musicbrainzngs
                quodlibet
                vorbisgain
                vorbis-tools
              ];
            })
            ({ config, pkgs, ... }: {
              boot.kernelParams = [
                "i915.enable_guc=2"
              ];
              
              nixpkgs.config.allowUnfree = true;
              
              hardware = {
                enableAllFirmware = true;
                graphics = {
                  enable = true;
                  extraPackages = with pkgs; [
                    intel-compute-runtime
                    intel-media-driver
                    libva
                  ];
                };
              };
              
              services.jellyfin = {
                enable = true;
                group = "jellyfin";
                openFirewall = true;
                user = "jellyfin";
              };
              
              environment = {
                sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
                systemPackages = with pkgs; [
                  intel-gpu-tools
                  jellyfin-ffmpeg
                  libva-utils
                  libvdpau-va-gl
                  vaapiVdpau
                  vpl-gpu-rt
                ];
              };
            })
            ({ pkgs, ... }: {
              environment.systemPackages = with pkgs; [
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
            })
            ({ config, pkgs, ... }: {
              networking.firewall.allowedTCPPorts = [ 8080 ];
              services.homepage-dashboard = {
                allowedHosts = "*";
              #  allowedHosts = "main-host.manticore-elnath.ts.net:8080,localhost:8080,127.0.0.1:8080";
                enable = true;
                listenPort = 8080;
                openFirewall = true;
                settings = {
                  title = "Dashboard";
                  description = "The Atomic Ass's Amazing Dashboard";
                  background = {
                    image = "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop";
                    opacity = 50;
                  };
                  cardBlur = "sm";
                  headerStyle = "boxedWidgets";
                  theme = "dark";
                  color = "neutral";
                  layout = {
                    "Monitoring" = {
                      disableCollapse = true;
                      header = false;
                    };
                    "Multimedia" = {
                      disableCollapse = true;
                      header = false;
                    #  style = ;
                    };
                    "Servers" = {
                      disableCollapse = true;
                      header = false;
                    };
                  };
                };
                services = [
                  {
                    "Monitoring" = [
                      {
                        "pfSense" = {
                          href = "https://heimdall.${vars.tailscale-fqdn}/";
                          description = "pfSense Router (Heimdall)";
                          icon = "si-pfsense-#212121";
                          widget = {
                            type = "pfsense";
                            url = "https://heimdall.${vars.tailscale-fqdn}/";
                            headers.X-API-Key = "";
                            version = 2;
                            wan = "ix3";
                            fields = [ "load" "temp" "wanIP" "wanStatus" ];
                          };
                        };
                      }
                      {
                        "TrueNAS (Svartalfheim)" = {
                          href = "http://192.168.0.2";
                          description = "TrueNAS Server (Svartalfheim)";
                          icon = "si-truenas-#0095D5";
                          widget = {
                            type = "truenas";
                            url = "http://192.168.0.2";
                            key = "";
                            enablePools = true;
                            nasType = "core";
                          };
                        };
                      }
                    ];
                  }
                  {
                    "Multimedia" = [
                      {
                        "Jellyfin" = {
                          href = "http://main-host.${vars.tailscale-fqdn}:8096/";
                          description = "Multimedia Streamer";
                          icon = "si-jellyfin-#00A4DC";
                          widget = {
                            type = "jellyfin";
                            url = "http://main-host.${vars.tailscale-fqdn}:8096/";
                            key = "";
                            enableBlocks =  true;
                            enableNowPlaying = true;
                            enableUser = true;
                            showEpisodeNumber = true;
                            expandOneStreamToTwoRows = false;
                          };
                        };
                      }
                    ];
                  }
                  {
                    "Servers" = [
                      (mkGlancesService "main-host")
                      (mkGlancesService "n100-1")
                    ] ++ proxyServices;
                  }
                ];
                widgets = [
                  {
                    datetime = {
                      text_size = "x1";
                      format = {
                        dateStyle = "short";
                        timeStyle = "short";
                        hourCycle = "h23";
                      };
                    };
                  }
                  {
                    "search" = {
                      provider = "custom";
                      focus = true;
                      url = "https://www.startpage.com/sp/search?query=";
                      target = "_blank";
                    };
                  }
                ];
              };
              services.netdata = {
              #  config = {
              #};
                enable = true;
              };
            })
                enable = true;
              };
            })
          ];
        };
        n100 = mkSystem "n100" "x86_64-linux" [
          {
            system = "x86_64-linux";
            specialArgs = { inherit vars; };
            modules = [
              { boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; }
              { virtualisation.docker.enable = true; }
            ];
          }
        ];
      };
      images = {
        rpi3bplus = nixosConfigurations.rpi3bplus.config.system.build.sdImage;
      };
    };
}
