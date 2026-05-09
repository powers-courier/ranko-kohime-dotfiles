{
  description = "Ranko Kohime's Flake v2";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:openclaw/nix-openclaw";
    nix-openclaw.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
  nixpkgs,
  home-manager,
  nix-darwin,
  nix-openclaw,
  self,
  ...
  }@inputs:
    let
      inherit (nixpkgs) lib;
      autoHardware = (import ./lib/autoHardware.nix {});
      autoLib = import ./lib/autoLib.nix { inherit inputs lib mkHost autoHardware; };
      inherit (autoLib)
        autoModules
        autoLinuxHosts
        autoDarwinHosts
        jellyProxyGenerator
      ;
      vars = {
        tailscale-fqdn = "manticore-elnath.ts.net";
        truenas-ip = "192.168.168.2";
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
        platform ? null,
      } @ args:
        let
          isDarwin = platform == "darwin" || lib.hasSuffix "-darwin" system;
          isNixOS  = !isDarwin;
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
                evince
                firefox
                libreoffice-fresh
                vlc
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
        if isDarwin then
          inputs.nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = { inherit inputs self; };
            modules = lib.flatten [
              (builtins.attrValues autoModules)
              { networking.hostName = hostname; }
              extraModules
            ];
          }
        else
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
            };
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
      mkDarwin = { hostname, system ? "aarch64-darwin", extraModules ? [] }@args:
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs self; };
          modules = [
            (builtins.attrValues autoModules)
            { networking.hostName = hostname; }
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
#      lib = listFromFile;
      nixosModules = flakeModules ;
      darwinConfigurations = autoLib.autoDarwinHosts;
      homeConfigurations = nixpkgs.lib.genAttrs home-manager-usernames mkHome;
      images = {
        
      };
      nixosConfigurations = autoLib.autoLinuxHosts // autoLib.jellyProxyGenerator;
    };
}
