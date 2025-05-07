{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./autocmds.nix
    ./bufferline.nix
    ./options.nix
    ./keymaps.nix
    ./plugins/gitsigns.nix
    ./plugins/telescope.nix
    ./plugins/whichkey.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    vim-sleuth
  ];
}
