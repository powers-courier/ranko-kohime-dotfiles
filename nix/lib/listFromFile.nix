{ lib, ... }:

let
  listFromFile = {
    readLines = path:
      let
        content = builtins.readFile path;
        lines = lib.strings.splitString "\n" content;
      in
        lib.filter
          (line:
            let trimmed = lib.strings.trim line;
            in trimmed != "" && !(lib.strings.hasPrefix "#" trimmed)
          )
          lines;
  };
in

{ inherit listFromFile; }
