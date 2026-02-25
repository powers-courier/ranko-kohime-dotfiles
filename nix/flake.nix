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
      flakeModules = {
        defaultSettings = { config, lib, ... }: {
          options.defaultSettings.enable = lib.mkEnableOption "Default system settings" // { default = true; };
          config = lib.mkIf config.defaultSettings.enable {
            networking.networkmanager.enable = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
            time.timeZone = vars.timeZern;
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
            ./modules/cpuLimiter.nix
            ./modules/defaultBootloader.nix
            ({ pkgs, vars, ... }: {
              networking.hostName = name;
              system.stateVersion = "25.05";
              
              
            })
          ];
        };
      }) (builtins.genList (i: i) proxyCount));
    in
    rec {
      
      
      
    };
}
