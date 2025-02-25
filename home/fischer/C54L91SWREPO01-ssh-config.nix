{pkgs, ...}: {
  programs = {
    ssh = {
      matchBlocks = {
        inet = {hostname = "10.29.20.91";};
      };
    };
  };
}
