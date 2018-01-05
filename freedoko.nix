{ stdenv, fetchgit, asciidoc, dos2unix, gettext, gnome3, libxml2, makeWrapper, pkgconfig, rsync, tetex, which }:

stdenv.mkDerivation rec {
  name = "freedoko";
  version = "0.7.17";

  src = fetchgit {
    url = "https://gitlab.com/dknof/FreeDoko.git";
    rev = "refs/tags/v${version}";
    sha256 = "1c0nny7jqnnrw9l9y53256jb5zy10344w11rp3zgdzjij6mnbrbb";
  };

  enableParallelBuilding = true;
  buildInputs = [
    gnome3.gsettings_desktop_schemas
    gnome3.gtkmm
    gettext
  ];
  nativeBuildInputs = [
    asciidoc
    dos2unix
    libxml2
    makeWrapper
    pkgconfig
    rsync
    tetex
    which
  ];
  makeFlags = "PREFIX=$(out) USE_SOUND=false";
  buildFlags = "compile";
  patches = [ ./freedoko-no-doc.patch
              ./freedoko-install-path.patch
            ];
  preFixup = ''
    wrapProgram "$out/bin/FreeDoko" \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH:${gnome3.gsettings_desktop_schemas}/share"
  '';

  meta = with stdenv.lib; {
    description      = ''The cardgame "Doppelkopf"'';
    longDescription  = ''
       FreeDoko is a free implementation of the cardgame “Doppelkopf”.
       See http://free-doko.sourceforge.net for more information.
    '';
    homepage         = http://free-doko.sourceforge.net;
    repositories.git = https://gitlab.com/dknof/FreeDoko.git;
    license          = licenses.gpl2;
    maintainers      = with maintainers; [ kaiha ];
  };
}
