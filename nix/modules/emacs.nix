{ nixpkgs }:
{
  emacsPackage = nixpkgs.emacs.override {
    # Add any desired customization here, such as enabling additional Emacs packages
    nativeComp = true; # Example: enable native compilation if desired
  };

  # NixOS module for configuring Emacs
  config = { config, pkgs, ... }: {
    environment.systemPackages = [ pkgs.emacs ];

    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      # Additional Emacs settings could be specified here
      (setq-default initial-scratch-message
        (concat
          ";;░█▀▀░█▄█░█▀█░█▀▀░█▀▀\n"
          ";;░█▀▀░█░█░█▀█░█░░░▀▀█\n"
          ";;░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀\n"
          "\n"
          ";;  Task Failed Successfully.\n"))
    };
  };
}
