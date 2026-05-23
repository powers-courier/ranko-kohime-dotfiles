{ config, lib, programs, ... }: {
  options.defaultNanoRC.enable = lib.mkEnableOption "Sane defaults for nanorc" //
{ default = true; };
  config = lib.mkIf config.defaultNanoRC.enable {
    programs.nano = lib.mkForce {
      enable = true;
      nanorc = ''
        set autoindent
        set boldtext
        set constantshow
        set linenumbers
        set nowrap
        set smarthome
        set tabsize 2
        set tabstospaces
      '';
    };
  };
}
