with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "projects-shell";
  buildInputs = [ viddy visidata jless miller silver-searcher pkgs.nodejs-18_x nodePackages.npm ];
}
