{ config, pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ({ stdenv, fetchFromGitHub, python3 }:
      stdenv.mkDerivation {
        pname = "rffmpeg";
        version = "1.0.2"; # Latest as of now
        src = fetchFromGitHub {
          owner = "joshuaboniface";
          repo = "rffmpeg";
          rev = "df5214cc9d5eb843558752e30a0eee909d1fb99a";
          # nix-prefetch-github joshuaboniface rffmpeg
          sha256 = "sha256-y0skEOgs2DO/kgy2DvL/x4iWzEU3F4Vxiw47TFrVMRQ=";
        };
        buildInputs = [ python3 ];
        installPhase = ''
          mkdir -p $out/bin
          cp rffmpeg $out/bin/rffmpeg
          chmod +x $out/bin/rffmpeg
        '';
      }) {})
    ffmpeg-full
  ];
}
