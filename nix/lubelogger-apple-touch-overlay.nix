# lubelogger-apple-touch-overlay.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.lubelogger;

  # Temporary Docker image with the two symlinks
  lubeloggerWithAppleTouch = pkgs.dockerTools.buildImage {
    name = "lubelogger-with-apple-touch-icons";
    fromImage = pkgs.dockerTools.pullImage {
      imageName = "ghcr.io/hargata/lubelogger";
      finalImageTag = "latest";
      # sha256 can be left empty when using :latest — Nix will pull it
    };

    extraCommands = ''
      mkdir -p app/wwwroot

      # Main symlink you requested
      ln -sfn favicon.ico app/wwwroot/apple-touch-icon.png

      # Additional common Apple variant (recommended)
      ln -sfn favicon.ico app/wwwroot/apple-touch-icon-precomposed.png
    '';

    config = {
      WorkingDir = "/app";
      # Inherit CMD/ENTRYPOINT from the original image
    };
  };

in {
  options.services.lubelogger = {
    # We keep this option so you can still disable it temporarily if needed
    useAppleTouchSymlinkOverlay = mkOption {
      type = types.bool;
      default = true;                    # ← defaults to enabled as requested
      description = ''
        Enable temporary overlay that symlinks apple-touch-icon.png and
        apple-touch-icon-precomposed.png to favicon.ico inside the container.
        Delete lubelogger-apple-touch-overlay.nix when testing is complete.
      '';
    };
  };

  config = mkIf (cfg.enable && cfg.useAppleTouchSymlinkOverlay) {
    virtualisation.oci-containers.containers.lubelogger.image =
      "${lubeloggerWithAppleTouch.imageName}:${lubeloggerWithAppleTouch.imageTag}";

    warnings = [ ''
      LubeLogger Apple Touch Icon overlay is active (from lubelogger-apple-touch-overlay.nix).
      Remember to delete the overlay file and its import once testing is finished.
    '' ];
  };
}
