{ lib, pkgs, ... }:
{
  lsp.servers = {
    nil_ls = {
      enable = true;
      settings.settings = {
        formatting = {
          command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        };
        nix = {
          flake = {
            autoArchive = true;
          };
        };
      };
    };
  };
}
