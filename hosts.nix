let
  hosts = {
    beely = {
      type = "homeManager";
      hostPlatform = "x86_64-linux";
      address = "beely";
      remoteBuild = true;
      homeDirectory = "/home/sven";
    };
    struppi = {
      type = "homeManager";
      hostPlatform = "x86_64-linux";
      address = "struppi.effeffcee.de";
      remoteBuild = true;
      homeDirectory = "/home/sven";
    };
    maja = {
      type = "homeManager";
      hostPlatform = "x86_64-linux";
      address = "maja";
      remoteBuild = true;
      homeDirectory = "/home/sven";
    };
    nixvirt = {
      type = "nixos";
      hostPlatform = "x86_64-linux";
      address = "nixvirt";
      remoteBuild = true;
    };
    willi = {
      type = "nixos";
      hostPlatform = "x86_64-linux";
      address = "willi";
      remoteBuild = false;
    };
    # laptop = {
    #   type = "nixos";
    #   hostPlatform = "x86_64-linux";
    #   address = "laptop";
    #   remoteBuild = false;
    # };
    # work = {
    #   type = "nixos";
    #   hostPlatform = "x86_64-linux";
    #   address = "sven-work";
    #   remoteBuild = true;
    # };
    # pixel6 = {
    #   type = "nix-on-droid";
    #   hostPlatform = "aarch64-linux";
    #   address = "pixel6";
    #   remoteBuild = false;
    # };
  };

  inherit (builtins) attrNames concatMap listToAttrs filter;

  filterAttrs = pred: set:
    listToAttrs (concatMap (name: let value = set.${name}; in if pred name value then [{ inherit name value; }] else [ ]) (attrNames set));

  removeEmptyAttrs = filterAttrs (_: v: v != { });

  genSystemGroups = hosts:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
      systemHostGroup = name: {
        inherit name;
        value = filterAttrs (_: host: host.hostPlatform == name) hosts;
      };
    in
    removeEmptyAttrs (listToAttrs (map systemHostGroup systems));

  genTypeGroups = hosts:
    let
      types = [ "homeManager" "nixos" ];
      typeHostGroup = name: {
        inherit name;
        value = filterAttrs (_: host: host.type == name) hosts;
      };
    in
    removeEmptyAttrs (listToAttrs (map typeHostGroup types));

  genHostGroups = hosts:
    let
      all = hosts;
      systemGroups = genSystemGroups all;
      typeGroups = genTypeGroups all;
    in
    all // systemGroups // typeGroups // { inherit all; };
in
genHostGroups hosts
