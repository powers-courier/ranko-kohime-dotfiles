{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixpkgs, sops-nix }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        sops-nix.packages.x86_64-linux.sops-install-secrets
        nixpkgs.legacyPackages.x86_64-linux.age
        nixpkgs.legacyPackages.x86_64-linux.gnupg
        nixpkgs.legacyPackages.x86_64-linux.libfido2
        nixpkgs.legacyPackages.x86_64-linux.openssh
        nixpkgs.legacyPackages.x86_64-linux.pcsclite
        nixpkgs.legacyPackages.x86_64-linux.pinentry-curses
        nixpkgs.legacyPackages.x86_64-linux.pinentry-tty
        nixpkgs.legacyPackages.x86_64-linux.sops
        nixpkgs.legacyPackages.x86_64-linux.ssh-to-age
        nixpkgs.legacyPackages.x86_64-linux.yubikey-manager
      ];
      shellHook = ''
        export GPG_TTY=$(tty)
        gpgconf --kill gpg-agent
        gpg-connect-agent updatestartuptty /bye
        export PS1='\[\e[1;34m\][sops-nix dev]\[\e[0m\] \$ '
      '';
    };
  };
}
