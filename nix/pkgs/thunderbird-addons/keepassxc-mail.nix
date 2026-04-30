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
  version = "1.16";
  src = fetchurl {
    url = "https://github.com/kkapsner/keepassxc-mail/releases/download/v1.16/keepassxc_mail-1.16.20260226.0-tb.xpi";
    sha256 = "sha256-XQqpqpKED3IBb9Ma0uK0mFkKbOx0y9a1YGBA3FjC09A=";
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
