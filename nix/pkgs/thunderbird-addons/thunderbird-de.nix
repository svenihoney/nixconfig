{
  lib,
  stdenv,
  fetchurl,
  ...
}: let
  addonId = "langpack-de@thunderbird.mozilla.org";
in
  stdenv.mkDerivation {
    pname = "langpack-de";
    version = "149";
    src = fetchurl {
      url = "https://addons.thunderbird.net/thunderbird/downloads/file/1045485/deutsch_de_language_pack-149.0.20260320.185705-tb.xpi?src=";
      sha256 = "sha256-6K1sPU99tTbQupRa5mQrpn8IhNs2HNXvheeiLJKFrD0=";
    };
    dontUnpack = true;
    installPhase = ''
      dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
      mkdir -p "$dst"
      install -v -m644 "$src" "$dst/${addonId}.xpi"
    '';
    meta = with lib; {
      homepage = "https://services.addons.thunderbird.net/De/thunderbird/addon/tb-langpack-de/";
      description = "Thunderbird Language Pack for Deutsch (de) – German";
      license = licenses.mpl20;
      platforms = platforms.all;
    };
  }
