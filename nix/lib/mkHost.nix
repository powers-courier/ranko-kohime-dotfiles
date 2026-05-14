{ inputs, lib, autoModules, flakeModules, platformModules, nixpkgs, ... }:
{
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
      specialArgs = { inherit inputs; };
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
        { nixpkgs.overlays = [ inputs.nix-openclaw.overlays.default ]; }
        (roleModules.${role} or (throw "No role module defined for '${role}'"))
      ] ++ extraModules;
    };
