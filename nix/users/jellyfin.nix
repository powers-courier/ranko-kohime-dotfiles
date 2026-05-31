(lib.mkIf cfg.jellyfin.enable {
  groups.jellyfin = {
    gid = 8096;
    name = "jellyfin";
  };
  users.jellyfin = {
    extraGroups = [
      "render"
      "video"
    ];
    group = "jellyfin";
    isNormalUser = true;
    isSystemUser = lib.mkForce false;
    uid = 8096;
  };
})
