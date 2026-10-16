{
  config,
  pkgs,
  ...
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
    "image/jp2" = "vimiv.desktop";
    "image/jpeg2000" = "vimiv.desktop";
    "image/jpx" = "vimiv.desktop";
    "image/png" = "vimiv.desktop";
    "image/tiff" = "vimiv.desktop";
    "image/svg" = "vimiv.desktop";
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
