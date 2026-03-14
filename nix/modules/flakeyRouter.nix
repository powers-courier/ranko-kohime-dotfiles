{ config, lib, pkgs, ... }:

let
  cfg = config.flakey-router;
in
{
  options.flakey-router = with lib; {
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
}
