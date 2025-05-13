{
  imports = [./autogroups.nix];

  autoCmd = [
    {
      event = "TextYankPost";
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      #      group = "kickstart-highlight-yank";
      callback.__raw = ''function() vim.highlight.on_yank() end'';
    }
    {
      event = [ "CursorHold" "CursorHoldI" ];
      desc = "Highlift references while hovering";
      group = "kickstart-lsp-highlight";
      callback.__raw = ''function() vim.lsp.buf.document_highlight() end'';
    }
    {
      event = [ "CursorMoved" "CursorMovedI" ];
      desc = "Remove highlight references when moving cursor";
      group = "kickstart-lsp-highlight";
      callback.__raw = ''function() vim.lsp.buf.clear_references() end'';
    }
    {
      event = "LspDetach";
      desc = "Clear references on LspDetach";
      group = "kickstart-lsp-detach";
      callback.__raw = ''function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_auto_cmds { group = "kickstart-lsp-highlight", buffer = event.buf }
      end'';
    }
  ];
}
