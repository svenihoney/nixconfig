{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {

    # Alles andere nach compinit
    initContent = lib.mkAfter '' proxy() { export https_proxy=http://proxy.software.ads:8888; export http_proxy=http://proxy.software.ads:8888; export no_proxy=localhost,127.0.0.1,software.ads,192.168.11.0/24 } '';
  };
}
