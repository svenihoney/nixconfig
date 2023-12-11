{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    vimiv-qt
  ];
  xdg.mimeApps.defaultApplications = {
    "image/bmp" = "vimiv.desktop";
    "image/gif" = "vimiv.desktop";
    "image/jpeg" = "vimiv.desktop";
    "image/jpg" = "vimiv.desktop";
    "image/pjpeg" = "vimiv.desktop";
    "image/png" = "vimiv.desktop";
    "image/tiff" = "vimiv.desktop";
    "image/x-bmp" = "vimiv.desktop";
    "image/x-pcx" = "vimiv.desktop";
    "image/x-png" = "vimiv.desktop";
    "image/x-portable-anymap" = "vimiv.desktop";
    "image/x-portable-bitmap" = "vimiv.desktop";
    "image/x-portable-graymap" = "vimiv.desktop";
    "image/x-portable-pixmap" = "vimiv.desktop";
    "image/x-tga" = "vimiv.desktop";
    "image/x-xbitmap" = "vimiv.desktop";
    "image/heif" = "vimiv.desktop";
  };
}
