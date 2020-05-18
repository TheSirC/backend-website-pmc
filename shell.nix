{pkgs ? import <nixpkgs> {}}:

with pkgs;
let
  # Just a way to have the bootstrapping script standalone (with syntax highlighting)
  shellHook = builtins.readFile ./.shell.sh;
in
mkShell {
  buildInputs = [ pgcli postgresql_11 inotify-tools ];
  shellHook = ''
            ${shellHook}
  '';
  LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}
