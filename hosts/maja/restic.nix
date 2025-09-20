{
  config,
  lib,
  pkgs,
  ...
}: {
  # configure agenix secrets
  age.secrets = {
    "restic/env".file = ../../secrets/restic/env.age;
    "restic/password".file = ../../secrets/restic/password.age;
  };

  # configure restic backup services
  services.restic.backups = {
    home = {
      initialize = true;

      repository = "s3:s3.leiderfischer.de/host-backup/maja";
      environmentFile = config.age.secrets."restic/env".path;
      passwordFile = config.age.secrets."restic/password".path;

      paths = [
        "/home/sven/privat"
        "/home/sven/projects"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 1"
      ];
    };
  };
}
