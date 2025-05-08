{ lib, pkgs, ... }:
{
  imports = [
    ./nil-ls.nix
    ./zls.nix
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      nil_ls = {
        settings = {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
          root_markers = [ ".git" ];
        };
      };
    };
  };
}
