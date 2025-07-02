switchcmd := if env_var("TERM") == "dumb" { "sudo nixos-rebuild switch --flake ." } else { "nh os switch ." }
updatecmd := if `hostname | sha256sum` == "ea825d166dc3a3e07877d84b40cce6cacd116704411c38dc0c07002e1683b6b9  -" { "just home dodo" } else { switchcmd }
# alias willi := (deploy willi)
#default: deploy
default:
    {{ updatecmd }}

# maja: && (deploy "maja")
#     rm -f /home/sven/.gtkrc-2.0

#willi: (deploy "willi")

#home: (deploy "willi") (deploy "maja")
home host=`hostname`:
    echo nh home switch . -c {{ host }}

deploy host=`hostname`:
    deploy -s .#{{host}} -- --impure --verbose

build host=`hostname`:
    nh os build . -H {{host}}

clean:
    nix-collect-garbage -d --delete-older-than 1d

update:
    nix flake update

upgrade: update deploy
