{
  config,
  lib,
  ...
}: let
  csd = config.svenihoney.devel;
in {
  options.svenihoney.devel = {
    all = lib.mkOption {
      description = "Add development tools for all languages";
      default = false;
      type = lib.types.bool;
    };

    c = lib.mkOption {
      description = "Add development tools for C/C++";
      default = csd.all;
      type = lib.types.bool;
    };

    rust = lib.mkOption {
      description = "Add development tools for Rust";
      default = csd.all;
      type = lib.types.bool;
    };

    xml = lib.mkOption {
      description = "Add development tools for XML";
      default = csd.all;
      type = lib.types.bool;
    };

    python = lib.mkOption {
      description = "Add development tools for Python";
      default = csd.all;
      type = lib.types.bool;
    };

    lsp = lib.mkOption {
      description = "Enable LSP support";
      default = csd.c || csd.rust || csd.python;
    };

    dap = lib.mkOption {
      description = "Enable DAP support";
      default = csd.lsp;
    };
  };
}
