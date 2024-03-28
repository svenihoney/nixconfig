{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    lens
    k9s
  ];
}
