{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "switchaudio";
  version = "0.0.1";

  src = ./.;

  installPhase = ''
    install -D -m755 ${pname} $out/bin/${pname}
  '';

  meta = with lib; {
    description = "A script to switch audio output between HDMI and headset";
    license = licenses.unlicense;
    maintainers = with maintainers; [];
    mainProgram = "switchaudio";
    platforms = platforms.all;
  };
}
