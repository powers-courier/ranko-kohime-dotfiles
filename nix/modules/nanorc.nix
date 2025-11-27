{ config, lib, ... }: {
  options.nanorc.enable = lib.mkEnableOption "Enable system-wide nanorc configuration" // { default = true; };
  config = lib.mkIf config.nanorc.enable {
    programs.nano.nanorc = ''
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
}
