{
  imports = [
    ../../common/optional/nginx.nix
    ../../common/optional/mysql.nix
    ../../common/optional/postgres.nix

    ./binary-cache.nix
    ./paste-sven-me.nix
    ./disconic.nix

    ./hydra
    ./minecraft
  ];
}
