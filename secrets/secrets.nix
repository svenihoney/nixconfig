let
  sven = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0TbNZWAW4jZmjdrL4RMtuV11k2/0Ya1Mow44CAv0+z";
  fischer = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe/Zxuwysu4HI10NPuDKFxTBqpwVB6HY8i8T1+ynOqh";
  users = [sven fischer];

  nas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ9Eq6HD/KLe/DbZEv5nUmOHPOgeXP+KkKU1tq3yPvQl";
  maja = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhP1VoxGI946RmSiXjDnt7nIaORRyDdTKkYVLejcBJ5";
  systems = [nas maja];
in {
  "restic/env.age".publicKeys = users ++ systems;
  "restic/password.age".publicKeys = users ++ systems;
  "weatherapi/key.age".publicKeys = users ++ systems;
}
