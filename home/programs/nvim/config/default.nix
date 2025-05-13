{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./autocmds.nix
    ./bufferline.nix
    ./options.nix
    ./keymaps.nix
    # ./usercommands.nix
    ./lsp/lsp.nix
    ./plugins/blink-cmp.nix
    ./plugins/gitsigns.nix
    ./plugins/lazydev.nix
    ./plugins/lz-n.nix
    ./plugins/telescope.nix
    ./plugins/whichkey.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    vim-sleuth
  ];
}
