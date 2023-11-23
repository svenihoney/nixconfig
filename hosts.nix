let
  hosts = {
    beely = {
      type = "homeManager";
      hostPlatform = "x86_64-linux";
      address = "beely";
      remoteBuild = false;
      user = "sven";
    };
    struppi = {
      type = "homeManager";
      hostPlatform = "x86_64-linux";
      address = "struppi.effeffcee.de";
      remoteBuild = false;
      user = "sven";
    };
    # struppi = {
    #   type = "homeManager";
    #   hostPlatform = "x86_64-linux";
    #   address = "struppi.effeffcee.de";
    #   remoteBuild = true;
    #   homeDirectory = "/home/sven";
    # };
    maja = {
      type = "nixos";
      hostPlatform = "x86_64-linux";
      address = "maja";
      remoteBuild = true;
      #      user = "sven";
      #      homeDirectory = "/home/sven";
      user = "sven";
    };
    # nixvirt = {
    #   type = "nixos";
    #   hostPlatform = "x86_64-linux";
    #   address = "nixvirt";
    #   remoteBuild = true;
    #   user = "sven";
    # };
    willi = {
      type = "nixos";
      hostPlatform = "x86_64-linux";
      address = "willi";
      remoteBuild = false;
      user = "sven";
    };
  };

  inherit (builtins) attrNames concatMap listToAttrs filter;

  filterAttrs = pred: set:
    listToAttrs (concatMap
      (name:
        let
          value = set.${name};
        in
        if pred name value
        then [{ inherit name value; }]
        else [ ])
      (attrNames set));

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
