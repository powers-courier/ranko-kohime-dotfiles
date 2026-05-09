{
  hostname = "Johns-MacBook-Neo";
  system = "aarch64-darwin";
  platform = "darwin";
  modules = [
    {
      system.stateVersion = 5;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "zap";
        };
        casks = [
          "cursor"
          "github"
        ];
      };
      environment.systemPackages = with pkgs; [
        git
        gh
      ];
      programs = {
        git = {
          enable = true;
          userName = "John Powers";
          userEmail = "powers.courier@icloud.com";
        };
        zsh.enable = true;
      };
    }
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];
}
