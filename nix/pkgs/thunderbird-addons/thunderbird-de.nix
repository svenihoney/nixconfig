{
  lib,
  stdenv,
  fetchurl,
  pkgs,
  ...
}: let
  addonId = "langpack-de@thunderbird.mozilla.org";
in
  stdenv.mkDerivation {
    pname = "langpack-de";
    version = "150";
    src = fetchurl {
      # Check https://addons.thunderbird.net/de/thunderbird/addon/tb-langpack-de/versions/
      # Copy the link
      # Update the hash
      url = "https://addons.thunderbird.net/thunderbird/downloads/file/1046298/deutsch_de_language_pack-150.0.20260416.11526-tb.xpi";
      # hash = pkgs.lib.fakeHash;
      hash = "sha256-f7ZROuD3IY2+py8iu6p4KDgCt0ustiSdyegUI5fFD8w=";
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
