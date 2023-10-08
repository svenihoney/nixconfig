{ pkgs, lib, ... }: {
  home.packages = [ pkgs.yuzu-mainline ];

  home.persistence = {
    "/persist/home/sven" = {
      allowOther = true;
      directories = [ "Games/Yuzu" ".config/yuzu" ".local/share/yuzu" ];
    };
  };
}
