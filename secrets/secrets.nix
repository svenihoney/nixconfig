let
  sven = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0TbNZWAW4jZmjdrL4RMtuV11k2/0Ya1Mow44CAv0+z";
  users = [sven];

  nas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ9Eq6HD/KLe/DbZEv5nUmOHPOgeXP+KkKU1tq3yPvQl";
  maja = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhP1VoxGI946RmSiXjDnt7nIaORRyDdTKkYVLejcBJ5";
  systems = [nas maja];
in {
  "restic/env.age".publicKeys = users ++ systems;
  "restic/password.age".publicKeys = users ++ systems;
}
