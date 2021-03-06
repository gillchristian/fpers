let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz";
  }) {};

  # To update to a newer version of easy-purescript-nix, run:
  # nix-prefetch-git https://github.com/justinwoo/easy-purescript-nix
  #
  # Then, copy the resulting rev and sha256 here.
  # Last update: 2020-12-03
  pursPkgs = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "860a95cb9e1ebdf574cede2b4fcb0f66eac77242";
    sha256 = "1ly3bm6i1viw6d64gi1zfiwdvjncm3963rj59320cr15na5bzjri";
  }) { inherit pkgs; };

  twpurs = import (builtins.fetchGit {
    name = "twpurs";
    url = "https://github.com/gillchristian/tailwind-purs";
    rev = "df1a28567d577da0844594dd820c1ee7d5996a12";
  });

in pkgs.stdenv.mkDerivation {
  name = "fpers";
  LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
  buildInputs = with pursPkgs; with twpurs; [
    pursPkgs.purs
    pursPkgs.spago
    pursPkgs.zephyr
    pkgs.nodejs-12_x
    twpurs
  ];
}
