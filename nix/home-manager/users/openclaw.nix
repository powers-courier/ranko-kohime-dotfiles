{ config, pkgs, ... }: {
  home = {
    username = "openclaw";
    homeDirectory = "/home/openclaw";   # ← use /Users/openclaw on macOS
    stateVersion = config.system.stateVersion;
    packages = with pkgs; [
      neovim
    ];
  };
  programs = {
    git = {
      enable = true;
      userName = "OpenClaw";
      userEmail = "tamagotchi@";
    };
    home-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };
  };
}
