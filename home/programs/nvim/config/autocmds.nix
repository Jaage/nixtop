{self, ...}: {
  imports = [./autogroups.nix];

  autoCmd = [
    {
      event = "TextYankPost";
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      # group = "kickstart-highlight-yank";
      callback = { __raw = "function() vim.highlight.on_yank() end"; };
    }
  ];
}
