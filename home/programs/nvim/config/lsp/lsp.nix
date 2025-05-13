{
  imports = [
    ./nil-ls.nix
    ./zls.nix
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    # servers = {
    #   nil_ls = {
    #     settings = {
    #       capabilities = {
    #         textDocument = {
    #           semanticTokens = {
    #             multilineTokenSupport = true;
    #           };
    #         };
    #       };
    #       root_markers = [ ".git" ];
    #     };
    #   };
    # };

    keymaps.extra = [
      {
        mode = [ "n" "x" ];
        key = "ga";
        action = "code_action";
        options.desc = "[G]oto Code [A]ction";
      }
      {
        mode = "n";
        key = "gd";
        action.__raw = "require('telescope.builtin').lsp_definitions";
        options.desc = "[G]oto [D]efinition";
      }
      {
        mode = "n";
        key = "gD";
        action = "declaration";
        options.desc = "[G]oto [D]eclaration (header in C)";
      }
      {
        mode = "n";
        key = "gi";
        action.__raw = "require('telescope.builtin').lsp_implementations";
        options.desc = "[G]oto [I]mplementation";
      }
      {
        mode = "n";
        key = "gt";
        action.__raw = "require('telescope.builtin').lsp_type_definitions";
        options.desc = "[G]oto [T]ype Definition";
      }
    ];
  };
}
