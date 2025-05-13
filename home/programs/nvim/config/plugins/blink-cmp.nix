{
  plugins.blink-ripgrep.enable = true;
  plugins.blink-cmp = {
    enable = true;
   lazyLoad.settings.event = [
      "InsertEnter"
      "CmdlineEnter"
    ];
    # lazyLoad.settings.ft = "nix";
    settings = {
      appearance = {
        nerd_font_variant = "normal";
        use_nvim_cmp_as_default = true;
      };
      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 500;
        };
      };
      fuzzy.implementation = "lua";
      signature.enabled = true;
      sources = {
        default = [
          "lazydev"
          "lsp"
          "path"
          "ripgrep"
          "snippets"
          "buffer"
        ];
        providers = {
          lazydev = {
            module = "lazydev.integrations.blink";
            name = "LazyDev";
            score_offset = 100;
          };
          ripgrep = {
            async = true;
            module = "blink-ripgrep";
            name = "Ripgrep";
            opts = {
              future_features.backend.use = "gitgrep-or-ripgrep";
              prefix_min_len = 3;
              project_root_marker = ".git";
              project_root_fallback = true;
            };
            score_offset = 200;
          };
        };
      };
    };
  };
}
