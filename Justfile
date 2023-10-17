# alias willi := (deploy willi)
default: deploy

maja: && (deploy "maja")
    rm -f /home/sven/.gtkrc-2.0

willi: (deploy "willi")

deploy host=`hostname`:
    nix run nixpkgs#deploy-rs -- -s .#{{host}} -- --impure
