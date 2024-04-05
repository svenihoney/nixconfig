{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "lenopow";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "makifdb";
    repo = "lenopow";
    rev = version;
    hash = "sha256-24iGGanhXhuk3Db6ItPv1/uA6zTb96QxavfawreIYVY=";
  };

  makeFlags = ["PREFIX=$(out)"];

  meta = with lib; {
    description = "A script to enable/disable battery conservation mode in Lenovo Ideapad/LEGION notebooks";
    homepage = "https://github.com/makifdb/lenopow/";
    license = licenses.unlicense;
    maintainers = with maintainers; [];
    mainProgram = "lenopow";
    platforms = platforms.all;
  };
}
