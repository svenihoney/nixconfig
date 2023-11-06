{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    lens
    k9s
    (wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
      ];
    })
  ];
}
