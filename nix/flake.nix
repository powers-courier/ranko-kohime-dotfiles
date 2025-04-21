{
  description = "Ranko Kohime's Flake, now with 100% more ZFS!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, hardware, home-manager, ... }@inputs:

  let
    hardwareConfigs = {
      framework-7840u = {
        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];
      
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
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
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
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
        fileSystems."/" =
          { device = "/dev/disk/by-uuid/e2feb3c4-8705-40f5-a21b-91429d3e1bcd";
            fsType = "ext4";
          };
      
        fileSystems."/boot" =
          { device = "/dev/disk/by-uuid/B830-073C";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
          };
      };
      jelly-proxy-03 = {
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
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
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
        fileSystems."/" =
          { device = "/dev/disk/by-uuid/8bfa1c39-f4c5-4b66-8a9e-db7b7b7cbb72";
            fsType = "ext4";
          };
      
        fileSystems."/boot" =
          { device = "/dev/disk/by-uuid/19A8-4887";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
          };
      };
      main-host = {
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
        fileSystems."/" =
          { device = "zroot/root";
            fsType = "zfs";
          };
      
        fileSystems."/nix" =
          { device = "zroot/nix";
            fsType = "zfs";
          };
      
        fileSystems."/var" =
          { device = "zroot/var";
            fsType = "zfs";
          };
      
        fileSystems."/home" =
          { device = "zroot/home";
            fsType = "zfs";
          };
      
        fileSystems."/boot" =
          { device = "/dev/disk/by-uuid/A0D5-9779";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
          };
      };
      n100-1 = {
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
      
        fileSystems."/" =
          { device = "/dev/disk/by-uuid/3baf4636-0456-44fc-a48b-72fbb49cea3f";
            fsType = "ext4";
          };
      
        fileSystems."/boot" =
          { device = "/dev/disk/by-uuid/9BBB-EE1C";
            fsType = "vfat";
          };
      };
    };

    proxyCount = 4;
    Jelly-Proxy-Configs = builtins.listToAttrs (map (i: let
      num = if i < 9 then "0${toString (i + 1)}" else toString (i + 1);
      name = "jelly-proxy-${num}";
    in {
      inherit name;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit vars; };
        modules = [
          ({ config, lib, ... }: {
            networking.useDHCP = lib.mkDefault true;
            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
            hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
    
          hardwareConfigs.${name}
    
          ({ lib, pkgs, vars, ... }: {
            networking.hostName = name;
            system.stateVersion = "25.05";
            boot.loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
            networking.networkmanager.enable = true;
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
            programs.nano.nanorc = ''
              set autoindent
              set boldtext
              set constantshow
              set nowrap
              set smarthome
              set tabsize 2
              set tabstospaces
            '';
            environment.systemPackages = with pkgs; [
              byobu
              git
              glances
              lm_sensors
              tmux
              unison
            ];
            services.tailscale = {
              enable = true;
              openFirewall = true;
              port = 0;
            };
            time.timeZone = vars.timeZern;
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
            users.users.ranko = {
              isNormalUser = true;
              description = "Ranko Kohime";
              extraGroups = [ "jellyfin" "networkmanager" "wheel" ];
            };
            zramSwap = {
              enable = true;
              priority = 1;
              memoryPercent = 100;
              swapDevices = 1;
            };
            systemd.services.glances-server = {
              description = "Glances server";
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" ];
              serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.glances}/bin/glances -s";
                RemainAfterExit = false;
                Restart = "always";
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
    #        boot.kernelParams = [ "ro" ];
    #        
    #        services.journald.extraConfig = ''
    #          Storage=volatile
    #          RuntimeMaxUse=50M
    #        '';
    #        
    #        fileSystems."/tmp" = {
    #          device = "tmpfs";
    #          fsType = "tmpfs";
    #          options = [ "defaults" "noatime" "mode=1777" "size=8g" ];
    #        };
    #        fileSystems."/var/log" = {
    #          device = "tmpfs";
    #          fsType = "tmpfs";
    #          options = [ "defaults" "noatime" "mode=0755" "size=1g" ];
    #        };
    #        fileSystems."/var/tmp" = {
    #          device = "tmpfs";
    #          fsType = "tmpfs";
    #          options = [ "defaults" "noatime" "mode=1777" "size=1g" ];
    #        };
          })
    
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              glances
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
      };
    }) (builtins.genList (i: i) proxyCount));

    vars = {
      loKale = "en_US.UTF-8";
      timeZern = "Etc/UTC";
      tailscale-fqdn = "manticore-elnath.ts.net";
      truenas-ip = "192.168.168.2";
    };
  in
    {
      nixosConfigurations = Jelly-Proxy-Configs // {
        framework-7840u = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            ({ config, lib, ... }: {
              networking.useDHCP = lib.mkDefault true;
              nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
              hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            })
        
            hardwareConfigs.framework-7840u
        
            ({ lib, pkgs, vars, ... }: {
              boot.loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
              };
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
              networking.networkmanager.enable = true;
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
              programs.nano.nanorc = ''
                set autoindent
                set boldtext
                set constantshow
                set nowrap
                set smarthome
                set tabsize 2
                set tabstospaces
              '';
              environment.systemPackages = with pkgs; [
                byobu
                git
                glances
                lm_sensors
                tmux
                unison
              ];
              services.tailscale = {
                enable = true;
                openFirewall = true;
                port = 0;
              };
              time.timeZone = vars.timeZern;
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
              users.users.ranko = {
                isNormalUser = true;
                description = "Ranko Kohime";
                extraGroups = [ "jellyfin" "networkmanager" "wheel" ];
              };
              zramSwap = {
                enable = true;
                priority = 1;
                memoryPercent = 100;
                swapDevices = 1;
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
        
            ({ pkgs, ... }: {
              environment.systemPackages = [
                pkgs.pass
              ];
              programs.gnupg.agent = {
                 enable = true;
                 pinentryPackage = pkgs.pinentry-curses;
                 enableSSHSupport = true;
              };
              services.pcscd.enable = true;
            })
        
            ({ pkgs, ... }: {
              boot = {
                supportedFilesystems = [ "zfs" ];
                zfs.forceImportRoot = false;
              };
        
              environment.systemPackages = with pkgs; [
                flac
                handbrake
                mediainfo
                mkvtoolnix
                python312Packages.musicbrainzngs
                quodlibet
                vorbisgain
                vorbis-tools
                deadnix
                statix
                byobu
                glances
                lm_sensors
                neovim
                ranger
                tmux
                tree
              ];
        
              networking = {
                hostId = "af2f1b7f";
                hostName = "framework-7840u";
              };
        
              system.stateVersion = "25.05";
            })
          ];
        };
        main-host = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            ({ config, lib, ... }: {
              networking.useDHCP = lib.mkDefault true;
              nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
              hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            })
        
            hardwareConfigs.main-host
        
            ({ lib, pkgs, vars, ... }: {
              boot.loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
              };
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
              networking.networkmanager.enable = true;
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
              programs.nano.nanorc = ''
                set autoindent
                set boldtext
                set constantshow
                set nowrap
                set smarthome
                set tabsize 2
                set tabstospaces
              '';
              environment.systemPackages = with pkgs; [
                byobu
                git
                glances
                lm_sensors
                tmux
                unison
              ];
              services.tailscale = {
                enable = true;
                openFirewall = true;
                port = 0;
              };
              time.timeZone = vars.timeZern;
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
              users.users.ranko = {
                isNormalUser = true;
                description = "Ranko Kohime";
                extraGroups = [ "jellyfin" "networkmanager" "wheel" ];
              };
              zramSwap = {
                enable = true;
                priority = 1;
                memoryPercent = 100;
                swapDevices = 1;
              };
            })
        
            ({ pkgs, vars, ... }: {
              boot = {
                supportedFilesystems = [ "zfs" ];
                zfs.forceImportRoot = false;
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
                handbrake
                mediainfo
                mkvtoolnix
                python312Packages.musicbrainzngs
                quodlibet
                vorbisgain
                vorbis-tools
              ];
            })
        
            ({ config, lib, pkgs, ... }: {
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
          ];
        };
        n100-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars; };
          modules = [
            ({ config, lib, ... }: {
              networking.useDHCP = lib.mkDefault true;
              nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
              hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            })
        
            hardwareConfigs.n100-1
        
            ({ pkgs, ... }: {
              environment.systemPackages = with pkgs; [
                flac
                handbrake
                mediainfo
                mkvtoolnix
                python312Packages.musicbrainzngs
                quodlibet
                vorbisgain
                vorbis-tools
                deadnix
                statix
                byobu
                glances
                lm_sensors
                neovim
                ranger
                tmux
                tree
                emacs
                ffmpeg-full
                gprename
                mate.engrampa
                neovim
                python3
              ];
              networking = {
                hostName = "n100-1";
                interfaces = {
                  enp2s0 = {
                    ipv4.addresses = [{
                      address = "192.168.168.20";
                      prefixLength = 24;
                    }];
                    mtu = 9000;
                  };
                };
              };
              system.stateVersion = "23.11";
            })
        
            ({ lib, pkgs, vars, ... }: {
              boot.loader = {
                efi.canTouchEfiVariables = true;
                systemd-boot.enable = true;
              };
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
              networking.networkmanager.enable = true;
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
              programs.nano.nanorc = ''
                set autoindent
                set boldtext
                set constantshow
                set nowrap
                set smarthome
                set tabsize 2
                set tabstospaces
              '';
              environment.systemPackages = with pkgs; [
                byobu
                git
                glances
                lm_sensors
                tmux
                unison
              ];
              services.tailscale = {
                enable = true;
                openFirewall = true;
                port = 0;
              };
              time.timeZone = vars.timeZern;
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
              users.users.ranko = {
                isNormalUser = true;
                description = "Ranko Kohime";
                extraGroups = [ "jellyfin" "networkmanager" "wheel" ];
              };
              zramSwap = {
                enable = true;
                priority = 1;
                memoryPercent = 100;
                swapDevices = 1;
              };
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
              programs.firefox.enable = true;
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
            })
        
            ({ pkgs, ... }: {
              environment.systemPackages = [
                pkgs.pass
              ];
              programs.gnupg.agent = {
                 enable = true;
                 pinentryPackage = pkgs.pinentry-curses;
                 enableSSHSupport = true;
              };
              services.pcscd.enable = true;
            })
        
          ];
        };
      };
    };
}
