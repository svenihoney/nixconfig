# alias willi := (deploy willi)
default: deploy

# maja: && (deploy "maja")
#     rm -f /home/sven/.gtkrc-2.0

willi: (deploy "willi")

home: (deploy "willi") (deploy "maja")

deploy host=`hostname`:
    deploy -s .#{{host}} -- --impure

clean:
    nix-collect-garbage -d --delete-older-than 1d

update:
    nix flake update

upgrade: update deploy
