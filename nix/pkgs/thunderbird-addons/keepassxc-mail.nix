{
  lib,
  stdenv,
  fetchurl,
  ...
}: let
  addonId = "keepassxc-mail@kkapsner.de";
in
stdenv.mkDerivation {
  pname = "keepassxc-mail";
  version = "1.18";
  src = fetchurl {
    url = "https://github.com/kkapsner/keepassxc-mail/releases/download/v1.18/keepassxc_mail-1.18.20260809.0-tb.xpi";
    sha256 = "sha256-yEC4L8hh/8ujDqI6iN5aeXZ1yHcaCQUB6nNzdjPKlFk=";
  };
  dontUnpack = true;
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"
    install -v -m644 "$src" "$dst/${addonId}.xpi"
  '';
  meta = with lib; {
    homepage = "https://github.com/kkapsner/keepassxc-mail";
    description = "Get passwords from keepassxc";
    license = licenses.mpl20;
    platforms = platforms.all;
  };
}
