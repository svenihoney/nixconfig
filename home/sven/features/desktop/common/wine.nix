{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [wineWowPackages.waylandFull winetricks];

  xdg.mimeApps.associations.removed = {
    "application/x-mswinurl" = "wine-extension-url.desktop";
    "text/plain" = "wine-extension-txt.desktop";
    "application/rtf" = "wine-extension-rtf.desktop";
    "image/png" = "wine-extension-png.desktop";
    "application/pdf" = "wine-extension-pdf.desktop";
    "image/jpeg" = ["wine-extension-jpe.desktop" "wine-extension-jfif.desktop"];
    "application/x-wine-extension-ini" = "wine-extension-ini.desktop";
    "application/winhlp" = "wine-extension-hlp.desktop";
    "text/html" = "wine-extension-htm.desktop";
    "application/vnd.ms-htmlhelp" = "wine-extension-chm.desktop";
    "image/gif" = "wine-extension-gif.desktop";
    "application/xml" = "wine-extension-xml.desktop";
    "application/x-mswrite" = "wine-extension-wri.desktop";
    "application/x-wine-extension-msp" = "wine-extension-msp.desktop";
    "text/vbscript" = "wine-extension-vbs.desktop";
  };
}
