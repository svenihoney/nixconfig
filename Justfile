# alias willi := (deploy willi)

maja: && (deploy "maja")
    rm -f /home/sven/.gtkrc-2.0

willi: (deploy "willi")

deploy host='maja':
    nix run nixpkgs#deploy-rs -- -s .#{{host}} -- --impure
