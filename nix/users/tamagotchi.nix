(lib.mkIf cfg.tamagotchi.enable {
  groups.tamagotchi = {
    gid = 18789;
    name = "tamagotchi";
  };
  users.tamagotchi = {
    createHome = true;
    group = "tamagotchi";
    home = "/var/lib/tamagotchi";
    isSystemUser = true;
    shell = "/run/current-system/sw/bin/bash";
    uid = 18789;
  };
})
