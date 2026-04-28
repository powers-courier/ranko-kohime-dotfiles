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
  outputs = {
  nixpkgs,
  home-manager,
  nix-openclaw,
  self,
  ...
  }@inputs:
    let
      inherit (nixpkgs) lib;
      listFromFile = {
        readLines = path:
          let
            content = builtins.readFile path;
            lines = nixpkgs.lib.strings.splitString "\n" content;
          in
            nixpkgs.lib.filter
              (line:
                let trimmed = nixpkgs.lib.strings.trim line;
                in trimmed != "" && !(nixpkgs.lib.strings.hasPrefix "#" trimmed)
              )
              lines;
      };
      vars = {
        tailscale-fqdn = "manticore-elnath.ts.net";
        truenas-ip = "192.168.168.2";
      };
      hardwareConfigs = {
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
          system.stateVersion = "25.05";
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
          system.stateVersion = "25.05";
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
          system.stateVersion = "25.05";
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
          system.stateVersion = "25.05";
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
          system.stateVersion = "25.05";
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
          system.stateVersion = "25.05";
        };
      };
      
      flakeModules = {
        flakeyRouter = { config, lib, pkgs, ... }:
        
        let
          cfg = config.flakeyRouter;
        in
        {
          options.flakeyRouter = with lib; {
            enable = mkEnableOption "basic home/SOHO router functionality"
              // { default = false; };  # ← explicitly default to off (common pattern)
        
            lanInterface = mkOption {
              type        = types.str;
              default     = "enp2s0";
              description = "LAN-facing network interface";
            };
        
            wanInterface = mkOption {
              type        = types.str;
              default     = "enp1s0";
              description = "WAN/ISP-facing network interface";
            };
        
            lan = {
              subnet = mkOption {
                type        = types.str;
                default     = "192.168.88.0/24";
                description = "LAN subnet in CIDR notation";
              };
        
              gateway = mkOption {
                type        = types.str;
                default     = "192.168.88.1";
                description = "Router's IP on the LAN interface";
              };
        
              dhcpRange = mkOption {
                type = types.str;
                default = "192.168.42.100,192.168.42.200,12h";
                description = "dnsmasq DHCP range (start,end,lease-time)";
              };
            };
        
            upstreamDns = mkOption {
              type = types.listOf types.str;
              default = [
                "1.1.1.1"
                "1.0.0.1"
                "2606:4700:4700::1111"
                "2606:4700:4700::1001"
                        ];
              description = "Upstream DNS servers to forward queries to";
            };
          };
        
          config = lib.mkIf cfg.enable {
        
            boot.kernel.sysctl = {
              "net.ipv4.ip_forward"              = lib.mkDefault 1;
              "net.ipv6.conf.all.forwarding"     = lib.mkDefault 1;
              "net.ipv6.conf.default.forwarding" = lib.mkDefault 1;
            };
        
            # ──────────────────────────────────────────────────────────────
            #  Networking basics
            # ──────────────────────────────────────────────────────────────
            networking = {
              useNetworkd = true;
              useDHCP     = false;
        
              interfaces.${cfg.lanInterface} = {
                ipv4.addresses = [{
                  address      = cfg.lan.gateway;
                  prefixLength = 24;
                }];
              };
        
              interfaces.${cfg.wanInterface}.useDHCP = true;
            };
        
            networking.nftables = {
              enable   = true;
              ruleset  = ''
                table inet filter {
                  chain input {
                    type filter hook input priority 0; policy drop;
                    ct state { established, related } accept
                    ct state invalid drop
                    iifname "lo" accept
                    iifname "${cfg.lanInterface}" accept
                    # ICMPv4
                    ip protocol icmp icmp type { destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem } accept
                    # ICMPv6 / NDP
                    ip6 nexthdr icmpv6 icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, mld-listener-query, mld-listener-report, mld-listener-reduction } accept
                  }
                  chain forward {
                    type filter hook forward priority 0; policy drop;
                    ct state { established, related } accept
                    ct state invalid drop
                    iifname "${cfg.lanInterface}" oifname "${cfg.wanInterface}" accept
                    iifname "${cfg.wanInterface}" oifname "${cfg.lanInterface}" ct state established,related accept
                  }
                  chain output {
                    type filter hook output priority 0; policy accept;
                  }
                }
                table ip nat {
                  chain postrouting {
                    type nat hook postrouting priority 100; policy accept;
                    oifname "${cfg.wanInterface}" masquerade
                  }
                }
              '';
            };
            # Disable default iptables firewall – we're using nftables
            networking.firewall.enable = false;
        
            services.dnsmasq = {
              enable = true;
            
              settings = {
                interface          = cfg.lanInterface;
                bind-interfaces    = true;
                except-interface   = cfg.wanInterface;
            
                dhcp-range         = cfg.lan.dhcpRange;
                dhcp-option        = [
                  "option:router,${cfg.lan.gateway}"
                  "option:dns-server,${cfg.lan.gateway}"
                ];
            
                server             = cfg.upstreamDns;
                no-resolv          = true;
            
                domain             = "lan";
                expand-hosts       = true;
                local              = "/lan/";
            
                strict-order       = true;
              };
            };
            environment.systemPackages = with pkgs; [
              bind.dnsutils
              ethtool
              iproute2
              nftables
              tcpdump
            ];
            # Optional: Avahi for local discovery
            services.avahi = {
              enable = cfg.enableAvahi;
              nssmdns4 = true;
              publish = {
                enable = true;
                addresses = true;
                userServices = true;
              };
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
        value = mkHost {
          hostname = name;
          system = "x86_64-linux";
          cpuVendor = "intel";
          role = "server";
          extraModules = [
            hardwareConfigs.${name}
            ({ ... }: {
              cpuLimiterIntel.enable = true;
              jellyfinProxyHost.enable = true;
            })
          ];
        };
      }) jellyProxyHosts);
      platformModules = {
        x86_64-linux = { cpuVendor ? "generic", ... }: [
          ({ pkgs, lib, ... }: {
            # Base x86_64 settings everyone gets
            boot.kernelPackages = pkgs.linuxPackages_latest;
            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
          })
          (lib.mkIf (cpuVendor == "intel") { platformModuleIntel.enable = true; })
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
      } @ args:
        let
          selectedPlatformModules =
            platformModules.${system} or
              (throw "Unsupported system: ${system}");
          platformModuleList = selectedPlatformModules {
            inherit system cpuVendor;
            inherit inputs;
            inherit (args) hostname;   # if needed inside
          };
          roleModules = {
            desktop = { pkgs, ... }: {
              fancyKeyboards.enable = true;
              multimediaPackages.enable = true;
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
              ];
            };
            laptop = { pkgs, ... }: {
              imports = [ roleModules.desktop ];
              environment.systemPackages = with pkgs; [
                byobu # Just to have non-empty list
              ];
              laptopFixes.enable = true;
            };
            minimal = { ... }: {
              environment.systemPackages = lib.mkForce [];
            };
            router = { ... }: {
              my-router.enable = true;
            };
            server = { lib, pkgs, ... }: {
              security.disableWireless.enable = true;
              boot.kernelParams = [ "quiet" "splash" ];
              services.xserver.enable = lib.mkForce false;
              networking.firewall.enable = true;
              services.printing.enable = lib.mkForce false;
              networking.networkmanager.enable = lib.mkForce false;  # usually no NM on servers
            };
            # Future roles (placeholders)
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
      #    inherit inputs;
          modules = lib.flatten [
            platformModuleList
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
            (builtins.attrValues autoModules)
            (builtins.attrValues flakeModules)
            { networking.hostName = hostname; }
            (roleModules.${role} or (throw "No role module defined for '${role}'"))
          ] ++ extraModules;
        };
      home-manager-homeDir = ./home-manager/users;
      home-manager-userFiles = builtins.attrNames (
        nixpkgs.lib.filterAttrs (name: type:
          type == "regular" &&
          nixpkgs.lib.hasSuffix ".nix" name &&
          name != "default.nix"
        ) (builtins.readDir home-manager-homeDir)
      );
      home-manager-usernames = builtins.map (f: nixpkgs.lib.removeSuffix ".nix" f) home-manager-userFiles;
      mkHome = home-manager-username: home-manager.lib.homeManagerConfiguration {
      #  inherit pkgs;
        modules = [ (home-manager-homeDir + "/${home-manager-username}.nix") ];
      };
    in
    rec {
      lib = listFromFile;
      nixosModules = autoModules // flakeModules ;
      homeConfigurations = nixpkgs.lib.genAttrs home-manager-usernames mkHome;
      nixosConfigurations = Jelly-Proxy-Configs // {
        framework-13 = mkHost {
          hostname = "framework-13";
          system = "x86_64-linux";
          cpuVendor = "intel";
          role = "laptop";
          extraModules = [
            { desktopXFCE.enable = true; }
            { zfsBootOptions.enable = true; }
            {
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
            }
          ];
        };
        router-ask = mkHost {
          hostname = "router-ask";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            { system.stateVersion = "26.05"; }
        #    { flakeyRouter.enable = true; }
            {
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
            }
          ];
        };
        main-host = mkHost {
          hostname = "main-host";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            { jellyfinServer.enable = true; }
        #    { services.LubeLogger.enable = true; }
            { zfsBootOptions.enable = true; }
            {
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
              system.stateVersion = "25.05";
            }
          ];
        };
        n100-1 = mkHost {
          hostname = "n100-1";
          system = "x86_64-linux";
          cpuVendor = "intel";
          extraModules = [
            {
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
              system.stateVersion = "25.05";
            }
          ];
        };
        tamagotchi = mkHost {
          hostname = "tamagotchi";
          system = "x86_64-linux";
          cpuVendor = "intel";
          role = "server";
          extraModules = [
            { openBot.enable = true; }
            {
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
              system.stateVersion = "25.05";
            }
          ];
        };
      };
      images = {
        
      };
    };
}
