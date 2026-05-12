let
  sven = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0TbNZWAW4jZmjdrL4RMtuV11k2/0Ya1Mow44CAv0+z";
  fischer = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe/Zxuwysu4HI10NPuDKFxTBqpwVB6HY8i8T1+ynOqh";
  me = "age1l5pmn9t4nw3cx9vjm987tkq8e55ea99ycwqlt2kzdr8hhkcd642s5d5yxt";
  users = [sven fischer me];

  puck = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPn6JX5pFfCe/05bwpp3kqrDX83JswN8M1ZgA9AbM9QZ";
  maja = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhP1VoxGI946RmSiXjDnt7nIaORRyDdTKkYVLejcBJ5";
  systems = [puck maja];
in {
  "restic/env.age".publicKeys = users ++ systems;
  "restic/password.age".publicKeys = users ++ systems;
  "weatherapi/key.age".publicKeys = users ++ systems;
  "signatures/leiderfischer.de.age".publicKeys = users ++ systems;
  "signatures/effeffcee.de.age".publicKeys = users ++ systems;
  "signatures/taxdigits.de.age".publicKeys = users ++ systems;
  "signatures/moitzfeld-ev.de.age".publicKeys = users ++ systems;
}
