{ config, lib, ... }: {
  options.opensshServer.enable = lib.mkEnableOption "Enable OpenSSH server, and Mosh" // { default = true; };
  config = lib.mkIf config.opensshServer.enable {
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
}
