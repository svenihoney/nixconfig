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
    # version = "152";
    version = pkgs.thunderbird.version;
    src = fetchurl {
      # Check https://addons.thunderbird.net/de/thunderbird/addon/tb-langpack-de/versions/
      # Copy the link
      # Update the hash
      # url = "https://addons.thunderbird.net/thunderbird/downloads/file/1046973/deutsch_de_language_pack-151.0.20260515.20702-tb.xpi?src=version-history";
      url = "https://download-origin.cdn.mozilla.net/pub/thunderbird/releases/${pkgs.thunderbird.version}/linux-x86_64/xpi/de.xpi";
      # hash = pkgs.lib.fakeHash;
      hash = "sha256-RTmiKav5+LTX+K8bBWe0l9npZo5lqef9udqi2jFcvsg=";
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
