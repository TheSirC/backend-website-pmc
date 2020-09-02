{pkgs ? import <nixpkgs> {}}:

with pkgs;
mkShell {
  buildInputs = [ pgcli postgresql_11 inotify-tools diesel-cli ];
  # Just a way to have the bootstrapping script standalone (with syntax highlighting)
  shellHook = builtins.readFile ./.shell.sh;
  LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}
