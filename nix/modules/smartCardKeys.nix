{ config, lib, pkgs, ... }: {
  options.smartCardKeys.enable = lib.mkEnableOption "Enable settings for Smart Cards and Yubikeys" //
    { default = true; };
  config = lib.mkIf config.smartCardKeys.enable {
    boot.kernelModules = [ "uhid" "hid_goodix" ];
    environment.systemPackages = with pkgs; [
      fprintd
      libfido2
      pam_u2f
      pass
      pinentry-curses
      yubico-piv-tool
      yubikey-agent
      yubikey-manager
      yubikey-personalization
      yubikey-touch-detector
    ];
    security.pam.services = {
      login.fprintAuth = true;
      sudo.fprintAuth = true;
        # For GNOME/KDE lockscreen (if using)
    # gdm.fprintAuth = true;  # GNOME
    # sddm.fprintAuth = true; # KDE/Sway/etc.
        # For i3lock or similar (if using)
    # i3lock.fprintAuth = true;
    };
    programs = {
      gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
      };
      yubikey-touch-detector.enable = true;
    };
    services = {
      fprintd = {
        enable = true;
        tod.enable = true;
        tod.driver = pkgs.libfprint-2-tod1-goodix;
      };
      pcscd.enable = true;
      yubikey-agent.enable = true;
    };
  };
}
