(lib.mkIf cfg.root.enable {
  users.root = {
    openssh.authorizedKeys.keys = [
    ];
  };
})
