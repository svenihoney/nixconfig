switchcmd := if env_var("TERM") == "dumb" { "sudo nixos-rebuild switch --flake ." } else { "nh os switch ." }
updatecmd := if `hostname` == "C54L91SWREPO01" { "just home" } else { switchcmd }
# alias willi := (deploy willi)
#default: deploy
default:
    {{ updatecmd }}

# maja: && (deploy "maja")
#     rm -f /home/sven/.gtkrc-2.0

#willi: (deploy "willi")

#home: (deploy "willi") (deploy "maja")
home:
    nh home switch . -c $(hostname)

deploy host=`hostname`:
    deploy -s .#{{host}} -- --impure --verbose

clean:
    nix-collect-garbage -d --delete-older-than 1d

update:
    nix flake update

upgrade: update deploy
