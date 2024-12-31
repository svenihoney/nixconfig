switchcmd := if env_var("TERM") == "dumb" { "sudo nixos-rebuild switch --flake ." } else { "nh os switch ." }
# alias willi := (deploy willi)
#default: deploy
default:
    {{switchcmd}}

# maja: && (deploy "maja")
#     rm -f /home/sven/.gtkrc-2.0

willi: (deploy "willi")

home: (deploy "willi") (deploy "maja")

deploy host=`hostname`:
    deploy -s .#{{host}} -- --impure --verbose

clean:
    nix-collect-garbage -d --delete-older-than 1d

update:
    nix flake update

upgrade: update deploy
